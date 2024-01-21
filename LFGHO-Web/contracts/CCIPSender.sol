// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract CCIP_Sender {
    using SafeERC20 for IERC20;

    address immutable i_router;
    uint64 immutable destinationChainSelector;

    event MessageSent(bytes32 messageId);

    constructor(address router, uint64 _destinationChainSelector) {
        i_router = router;
        destinationChainSelector = _destinationChainSelector;
    }

    receive() external payable {}

    function swapTokensCCIP(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOutMin,
        address recipient
    ) public payable {
        IERC20(tokenIn).safeTransferFrom(msg.sender, address(this), amountIn);
        IERC20(tokenIn).approve(i_router, amountIn);

        Client.EVMTokenAmount[] memory tokenToSend = new Client.EVMTokenAmount[](1);
        tokenToSend[0] = Client.EVMTokenAmount(tokenIn, amountIn);

        Client.EVM2AnyMessage memory message = Client.EVM2AnyMessage({
            receiver: abi.encode(recipient),
            data: abi.encodeWithSignature(
                "swapTokensForTokens(address,address,uint256,uint256,address)",
                tokenIn,
                tokenOut,
                amountIn,
                amountOutMin,
                recipient
            ),
            tokenAmounts: tokenToSend,
            extraArgs: "",
            feeToken: address(0)
        });

        uint256 fee = IRouterClient(i_router).getFee(destinationChainSelector, message);
        require(msg.value >= fee, "Insufficient fee");

        bytes32 messageId = IRouterClient(i_router).ccipSend{value: fee}(
            destinationChainSelector,
            message
        );

        emit MessageSent(messageId);
    }


}
