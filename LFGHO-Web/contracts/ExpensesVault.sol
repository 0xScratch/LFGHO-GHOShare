// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}
interface Aave {
    function borrow(address _reserve, uint _amount, uint _interestRateModel, uint16 _referralCode) external;
    function setUserUseReserveAsCollateral(address _reserve, bool _useAsCollateral) external;
    function repay(address _reserve, uint _amount, address payable _onBehalfOf) external payable;
    function getUserAccountData(address _user)
        external
        view
        returns (
            uint totalLiquidityETH,
            uint totalCollateralETH,
            uint totalBorrowsETH,
            uint availableBorrowsETH,
            uint currentLiquidationThreshold,
        );
}
interface AaveToken {
    function underlyingAssetAddress() external returns (address);
}
interface LendingPoolAddressesProvider {
    function getLendingPool() external view returns (address);
    function getLendingPoolCore() external view returns (address);
    function getPriceOracle() external view returns (address);
}

contract AaveCollateralVault {    
    address public constant aave = address(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);
    uint public model = 2;
    address public asset = address(0);
    
    address public _owner;
    address[] public _activeReserves;
    mapping(address => bool) _reserves;

        struct Expense {
        address member;
        uint256 amount;
    }

    Expense[] public expenses;

    function addExpense(address member, uint256 amount) public onlyOwner {
        expenses.push(Expense(member, amount));
    }

    function settleExpenses() public onlyOwner {
        uint256 totalExpenses = 0;
        for (uint i = 0; i < expenses.length; i++) {
            totalExpenses += expenses[i].amount;
        }

        uint256 sharePerMember = totalExpenses / expenses.length;
        for (uint i = 0; i < expenses.length; i++) {
            address member = expenses[i].member;
            uint256 owed = sharePerMember - expenses[i].amount;
            if (owed > 0) {
                IERC20 token = IERC20(addressOfToken);
                uint256 contractBalance = token.balanceOf(address(this));
                require(contractBalance >= owed, "Insufficient funds in contract for settlement");
                bool sent = token.transfer(member, owed);
                require(sent, "Failed to send token");
            }
        }
    }
    function delegateCredit(address delegatee, uint256 amount) public onlyOwner {
        require(delegatee != address(0), "Invalid delegatee address");
        ILendingPool lendingPool = ILendingPool(LendingPoolAddressesProvider(aave).getLendingPool());
        address asset = addressOfDepositedToken;
        IERC20(asset).approve(address(lendingPool), amount);
        lendingPool.delegateCredit(depositToken, delegatee, amount);
    }

    mapping(address => uint256) public delegatedCreditLimits;
    function borrow(address reserve, uint256 amount, address to) public onlyOwner {
        require(asset == reserve || asset == address(0), "Reserve not available");
        require(delegatedCreditLimits[reserve] >= amount, "Borrow amount exceeds delegated credit limit");
        Aave(getAave()).borrow(reserve, amount, model, 0); 
        IERC20(reserve).safeTransfer(to, amount);
        delegatedCreditLimits[reserve] -= amount;

    }
    function repay(address reserve, uint amount) external nonReentrant onlyOwner {
        // Required for certain stable coins (USDT for example)
        IERC20(reserve).approve(address(getAaveCore()), 0);
        IERC20(reserve).approve(address(getAaveCore()), amount);
        Aave(getAave()).repay(reserve, amount, address(uint160(address(this))));
    }

    function owner() public view returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(isOwner(), "!owner");
        _;
    }
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }
    
    constructor() public {
        _owner = msg.sender;
    }
    
    function setModel(uint _model) external onlyOwner {
        model = _model;
    }
    
    function setBorrow(address _asset) external onlyOwner {
        asset = _asset;
    }
    function getBorrow() external view returns (address) {
        return asset;
    }
    
    function getReserves() external view returns (address[] memory) {
        return _activeReserves;
    }
    
    // LP deposit, anyone can deposit/topup
    function activate(address reserve) external onlyOwner {
        if (_reserves[reserve] == false) {
            _reserves[reserve] = true;
            _activeReserves.push(reserve);
            Aave(getAave()).setUserUseReserveAsCollateral(reserve, true);
        }
    }

    // No logic, logic handled underneath by Aave
    function withdraw(address reserve, uint amount, address to) external onlyOwner {
        IERC20(reserve).safeTransfer(to, amount);
    }
    
    function getAave() public view returns (address) {
        return LendingPoolAddressesProvider(aave).getLendingPool();
    }
    
    function isReserve(address reserve) external view returns (bool) {
        return _reserves[reserve];
    }
    
    function getAaveCore() public view returns (address) {
        return LendingPoolAddressesProvider(aave).getLendingPoolCore();
    }

}

contract AaveCollateralVaultProxy {
    using Address for address;
    mapping (address => address[]) public _ownedVaults;
    mapping (address => address) public _vaults;
    mapping (address => mapping (address => uint)) public _limits;
    mapping (address => mapping (address => bool)) public _borrowerContains;
    mapping (address => address[]) public _borrowers;
    mapping (address => address[]) public _borrowerVaults;
    
    address public constant aave = address(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);
    address public constant link = address(0xF79D6aFBb6dA890132F9D7c355e3015f15F3406F);
    
    event IncreaseLimit(address indexed vault, address indexed owner, address indexed spender, uint limit);
    event DecreaseLimit(address indexed vault, address indexed owner, address indexed spender, uint limit);
    event SetModel(address indexed vault, address indexed owner, uint model);
    event SetBorrow(address indexed vault, address indexed owner, address indexed reserve);
    event Deposit(address indexed vault, address indexed owner, address indexed reserve, uint amount);
    event Withdraw(address indexed vault, address indexed owner, address indexed reserve, uint amount);
    event Borrow(address indexed vault, address indexed owner, address indexed reserve, uint amount);
    event Repay(address indexed vault, address indexed owner, address indexed reserve, uint amount);
    event DeployVault(address indexed vault, address indexed owner, address indexed asset);

    function increaseLimit(address vault, address spender, uint addedValue) external {
        require(isVaultOwner(address(vault), msg.sender), "!owner");
        if (!_borrowerContains[vault][spender]) {
            _borrowerContains[vault][spender] = true;
            _borrowers[vault].push(spender);
            _borrowerVaults[spender].push(vault);
        }
        uint amount = _limits[vault][spender].add(addedValue);
        _approve(vault, spender, amount);
        emit IncreaseLimit(vault, msg.sender, spender, amount);
    }
    
    function decreaseLimit(address vault, address spender, uint subtractedValue) external {
        require(isVaultOwner(address(vault), msg.sender), "!owner");
        uint amount = _limits[vault][spender].sub(subtractedValue, "<0");
        _approve(vault, spender, amount);
        emit DecreaseLimit(vault, msg.sender, spender, amount);
    }
    
    function setModel(AaveCollateralVault vault, uint model) external {
        require(isVaultOwner(address(vault), msg.sender), "!owner");
        vault.setModel(model);
        emit SetModel(address(vault), msg.sender, model);
    }
    
    function getBorrow(AaveCollateralVault vault) external view returns (address) {
        return vault.getBorrow();
    }
    
    function _approve(address vault, address spender, uint amount) internal {
        require(spender != address(0), "address(0)");
        _limits[vault][spender] = amount;
    }
    
    function isVaultOwner(address vault, address owner) public view returns (bool) {
        return _vaults[vault] == owner;
    }
    function isVault(address vault) public view returns (bool) {
        return _vaults[vault] != address(0);
    }
    
    // LP deposit, anyone can deposit/topup
    function deposit(AaveCollateralVault vault, address aToken, uint amount) external {
        require(isVault(address(vault)), "!vault");
        IERC20(aToken).safeTransferFrom(msg.sender, address(vault), amount);
        address underlying = AaveToken(aToken).underlyingAssetAddress();
        if (vault.isReserve(underlying) == false) {
            vault.activate(underlying);
        }
        emit Deposit(address(vault), msg.sender, aToken, amount);
    }
    
    // No logic, handled underneath by Aave
    function withdraw(AaveCollateralVault vault, address aToken, uint amount) external {
        require(isVaultOwner(address(vault), msg.sender), "!owner");
        vault.withdraw(aToken, amount, msg.sender);
        emit Withdraw(address(vault), msg.sender, aToken, amount);
    }
    
    // amount needs to be normalized
    function borrow(AaveCollateralVault vault, address reserve, uint amount) external {
        require(isVault(address(vault)), "!vault");
        uint _borrow = amount;
        if (vault.asset() == address(0)) {
            _borrow = getReservePriceUSD(reserve).mul(amount);
        }
        _approve(address(vault), msg.sender, _limits[address(vault)][msg.sender].sub(_borrow, "borrow amount exceeds allowance"));
        vault.borrow(reserve, amount, msg.sender);
        emit Borrow(address(vault), msg.sender, reserve, amount);
    }
    
    function repay(AaveCollateralVault vault, address reserve, uint amount) external {
        require(isVault(address(vault)), "!vault");
        IERC20(reserve).safeTransferFrom(msg.sender, address(vault), amount);
        vault.repay(reserve, amount);
        emit Repay(address(vault), msg.sender, reserve, amount);
    }
    
    function getVaults(address owner) external view returns (address[] memory) {
        return _ownedVaults[owner];
    }
    
    function deployVault(address _asset) external returns (address) {
        address vault = address(new AaveCollateralVault());
        AaveCollateralVault(vault).setBorrow(_asset);
        // Mark address as vault
        _vaults[vault] = msg.sender;
        
        // Set vault owner
        _ownedVaults[msg.sender].push(vault);
        emit DeployVault(vault, msg.sender, _asset);
        return vault;
    }
    
    function getVaultAccountData(address _vault)
        external
        view
        returns (
            uint totalLiquidityUSD,
            uint totalCollateralUSD,
            uint totalBorrowsUSD,
            uint totalFeesUSD,
            uint availableBorrowsUSD,
            uint currentLiquidationThreshold,
            uint ltv,
            uint healthFactor
        ) {
        (
            totalLiquidityUSD,
            totalCollateralUSD,
            totalBorrowsUSD,
            totalFeesUSD,
            availableBorrowsUSD,
            currentLiquidationThreshold,
            ltv,
            healthFactor
        ) = Aave(getAave()).getUserAccountData(_vault);
        uint ETH2USD = getETHPriceUSD();
        totalLiquidityUSD = totalLiquidityUSD.mul(ETH2USD);
        totalCollateralUSD = totalCollateralUSD.mul(ETH2USD);
        totalBorrowsUSD = totalBorrowsUSD.mul(ETH2USD);
        totalFeesUSD = totalFeesUSD.mul(ETH2USD);
        availableBorrowsUSD = availableBorrowsUSD.mul(ETH2USD);
    }
