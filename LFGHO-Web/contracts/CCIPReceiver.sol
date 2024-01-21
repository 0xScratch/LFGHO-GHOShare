// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

import "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";

contract CCIP_Receiver is Ownable, CCIPReceiver {
    using SafeERC20 for IERC20;

    IUniswapV2Router02 public uniswapRouter;
    address public gho;

    event MessageReceived(
        bytes32 indexed latestMessageId,
        address indexed recipient
    );

    constructor(
        address router,
        address gho_,
        address uniswapRouter_
    ) CCIPReceiver(router) Ownable(msg.sender) {
        gho = gho_;
        uniswapRouter = IUniswapV2Router02(uniswapRouter_);
    }

    function _ccipReceive(
        Client.Any2EVMMessage memory message
    ) internal override {
        (
            bytes4 functionSelector,
            address tokenIn,
            address tokenOut,
            uint256 amountIn,
            uint256 amountOutMin,
            address recipient
        ) = abi.decode(message.data, (bytes4, address, address, uint256, uint256, address));

        if (functionSelector == bytes4(keccak256("swapTokensForTokens(address,address,uint256,uint256,address)"))) {
            _swapTokensForTokens(tokenIn, tokenOut, amountIn, amountOutMin, recipient);
        }

        emit MessageReceived(
            message.messageId,
            recipient
        );
    }

    function _swapTokensForTokens(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOutMin,
        address to
    ) private {
        IERC20(tokenIn).safeTransferFrom(msg.sender, address(this), amountIn);
        IERC20(tokenIn).approve(address(uniswapRouter), amountIn);

        address[] memory path = new address[](2);
        path[0] = tokenIn;
        path[1] = tokenOut;

        uniswapRouter.swapExactTokensForTokens(
            amountIn,
            amountOutMin,
            path,
            to,
            block.timestamp
        );
    }

    // Administrative function to allow the owner to withdraw tokens from the contract.
    function withdrawToken(address token, address to, uint256 amount) external onlyOwner {
        IERC20(token).safeTransfer(to, amount);
    }
}
