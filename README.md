# GhoShare

ETH Global Link: https://ethglobal.com/showcase/ghoshare-nggb3

Winner Of: 
- Aave - Payments 1st place
- Chainlink - Best Projects Built with CCIP and GHO

<p align="center">
  <img src="ghoshareimg.png" alt="Ghoshare Image" width="20%" height="auto"/>
</p>

GhoShare is an iOS app created to address the spesific shortcoming in current expense splitting apps by enabling decentralised direct in-app settlements of payments using credit delegation, token swapping and cross-network transactions. Secured by biometric authentication and EIP 4337 smart accounts.

GhoShare onboards the market of iOS users into the Aave ecosystem and incentivises users to mint GHO, expanding the utility and ways people can spend GHO.


# Main Features
- Custom payment protocol using payment contracts, Chainlink CCIP for cross-network transactions and 1inch fork for token swapping.
- Credit Delegation Vault for group expense management.
- EIP 2612 Permit function to allow for signature based pre-approval of funds for expenses by the group leader.
- Secure and easy onboarding using account abstraction and EIP 4337 smart accounts.
- Turnkey to generate signer wallet for smart account secured by FaceID biometric authentication.
- Aave V3 Ethereum Facilitator for minting GHO tokens in an overcollateralized manner.
- Unlimit iOS SDK for onramping crypto using fiat payments.
- Pimlico paymaster and permissionless.js for smart contract deployment.
- GHO facilitator activity shown using Ethereum Mainnet GraphQL subgraph endpoint.
- Transactions history shown from the event logs of contracts, swaps and transactions using historical balance.
- Notification alert to sender and receiver for confirmation of funds.

# Video
Please click on the thumbnail below to view our demo.
[![Video Thumbnail](https://img.youtube.com/vi/peU-QWqdiw8/maxresdefault.jpg)](https://youtu.be/peU-QWqdiw8)


# Workflow
## User Onboarding
### Sign Up:
- Secure & easy onboarding using account abstraction and EIP 4337 smart accounts.
- Wallet created via FaceID using a turnkey to generate a signer wallet for the smart account.
- Deployed using Pimlico paymaster using permissionless.js to provide a gasless UX.

### Sign In:
- Sign in using Metamask SDK

### Fund Account:
- Unlimit iOS SDK for on-ramping crypto using Fiat.
- Aave V3 ETH Facilitator for minting GHO tokens in an overcollateralized manner.
    - Use UiPoolDataProviderV3 contracts (`getReservesData()`) and the Lending Pool contract to deposit collateral.
    - `borrow()` called to mint GHO.

## Expense Splitting Groups
Depositors provide liquidity for the expense to be paid by depositing assets like GHO into the Aave protocol. They can then delegate their credit lines to the vault contract which acts on behalf of the group for expense management. The vault acts as the borrower to borrow funds against the deposited collateral up to the delegated limit.

### Credit Delegation Vault for Group Expense Management:
- Depositors provide liquidity for the expense to be paid by depositing assets such as GHO into the Aave protocol.
- They can delegate their credit lines to the vault contract which acts on behalf of the group for expense management.
- The vault acts as the borrower to borrow funds against the deposited collateral up to the delegated limit.
- `ExpensesVault.sol` to act as a credit delegation vault, functions to handle deposits, delegate credit, track outstanding debts, and manage repayments.
- Check if the user is authorized and their request exceeds the credit limit.
- Handle credit from multiple depositors.
- Contract manages repayments to make sure they are made on time to avoid liquidation.
- Users don't have to lock up capital; they can leverage their assets by borrowing against them.
- When a user needs to delegate GHO to another user for an expense, they sign an EIP 2612 permit message with the details of the delegation. This can be submitted to the token contract to obtain the allowed amount without requiring the delegator to perform a transaction, making it easier/smooth and saving gas fees.
- Incorporate a workflow system using account abstraction (AA)
- Cost Splitting Templates for recurring expenses

## Payments
The protocol allows for a combination of transactions where the user can supply ETH as collateral, borrow GHO and switch and transfer the borrowed GHO into ETH, using 1inch. Here the user maintains 100% of their exposure to ETH while still utilising the GHO token for payments.

### Custom payment protocol:
- The protocol allows for a combination of transactions where the user can supply ETH as collateral, borrow GHO, and switch and transfer the borrowed GHO into ETH, using 1inch.
- Here the user maintains 100% of their exposure to ETH while still utilizing the GHO token for payments.
- Chainlink CCIP for cross-network transactions
- 1inch fork is used for token swapping,

## Activity/Social:

### Displaying activity of friends transactions, swaps, and deposits:
- GHO facilitator activity shown using Ethereum Mainnet GraphQL subgraph endpoint - which indexes events and can be used to query data about GHO facilitator and interactions with the Aave v3 market.
- Contract State Data: Query balance of a friend's account, like GHO data functions such as `totalSupply()`, `balanceOf()`, `allowance()`.
- Event Logs: Use filters for certain transactions or friends' accounts to emit logs for payments, swaps, or historical balance using functions such as `Transfer()`, `Approval()`.
- Historical information in the activity tab is useful for safety features, allowing users to see if they have transacted with a specific friend before.
- An notification alert will be sent to sender and receiver for confirmation of funds is triggered through the event logs.
- Customizable Privacy for what is displayed in the activity tab.

# Images
## Screenshots
<img src=https://github.com/nkoorty/lfgho/assets/80065244/183f4099-1d29-47d4-a9ef-2d6baced3723 width=19%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/8a210690-05a2-498a-8238-7d975762d0e7 width=19%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/b64b5472-1e6b-4612-94bb-ddcdd9bf0996 width=19%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/4cae5575-5be2-46a7-9a5f-846665297621 width=19%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/61c29197-1a2d-40a2-8ca4-ea39cf97e6d0 width=19%>

## Payment Protocol Diagram
![GhoShare Payment Protocol](https://github.com/nkoorty/ghoshare/assets/80065244/aecfd5d8-c096-44ea-b7f5-e33bd8191ab1)


# The GhoShare team
- [Jeevan Jutla](https://www.linkedin.com/in/jeevan-jutla/) - Backend Developer, prev Binance Security Engineer
- [Artemiy Malyshau](https://www.linkedin.com/in/artemiy-malyshau/) - Frontend Developer, Imperial CS and Engineering MSc 


 ![Solidity](https://img.shields.io/badge/Solidity-%23363636.svg?style=for-the-badge&logo=solidity&logoColor=white)
 ![TypeScript](https://img.shields.io/badge/typescript-%23007ACC.svg?style=for-the-badge&logo=typescript&logoColor=white)
 ![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
