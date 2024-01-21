// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

import "./CreateAccount.sol";

contract CreateAccountFactory {
    CreateAccount public immutable accountImplementation;

    constructor(IEntryPoint _entryPoint) {
        accountImplementation = new CreateAccount(_entryPoint);
    }

    function createAccount(address owner,uint256 salt) public returns (CreateAccount ret) {
        address addr = getAddress(owner, salt);
        uint codeSize = addr.code.length;
        if (codeSize > 0) {
            return CreateAccount(payable(addr));
        }
        ret = CreateAccount(payable(new ERC1967Proxy{salt : bytes32(salt)}(
                address(accountImplementation),
                abi.encodeCall(CreateAccount.initialize, (owner))
            )));
    }
    
    function getAddress(address owner,uint256 salt) public view returns (address) {
        return Create2.computeAddress(bytes32(salt), keccak256(abi.encodePacked(
                type(ERC1967Proxy).creationCode,
                abi.encode(
                    address(accountImplementation),
                    abi.encodeCall(CreateAccount.initialize, (owner))
                )
            )));
    }
}