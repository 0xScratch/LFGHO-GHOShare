# GhoShare

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

# Images
<img src=https://github.com/nkoorty/lfgho/assets/80065244/a3b22562-43d1-483f-ac95-c510334f8af8 width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/183f4099-1d29-47d4-a9ef-2d6baced3723 width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/8a210690-05a2-498a-8238-7d975762d0e7 width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/0a486b77-0571-4212-a8f4-26f06b90c2bb width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/b64b5472-1e6b-4612-94bb-ddcdd9bf0996 width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/4cae5575-5be2-46a7-9a5f-846665297621 width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/56d43240-7a83-4fef-a4f7-161d19b0e59f width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/61c29197-1a2d-40a2-8ca4-ea39cf97e6d0 width=12%>

# Workflow
When you download the app, you'll first be prompted to sign up or log in. You have two options for logging in: using a Metamask account or creating a new wallet through GhoShare's account abstraction and EIP 4337 smart accounts. Your wallet is secured with biometric authentication, using Apple's FaceID.

Once logged in, you can fund your account in two ways: either by using Unlimit to add funds or by using your existing ETH as collateral to mint GHO through the Aave Ethereum facilitator. You can also add friends by scanning their account-linked QR code.

The app allows you to create expense groups with your friends. As a group leader, you can choose to fund expenses either with your own liquidity or through a credit delegation settlement. If you opt for the latter, you'll deposit assets (like GHO) into the protocol and delegate your credit line to group members, splitting the expense. You can set a repayment deadline and specify the token for repayment. Each group acts as a credit delegation vault, and we utilize the EIP 2612 Permit function for pre-approving funds through signature-based authorization.

Group members have the flexibility to settle expenses using their own liquidity or by borrowing GHO. Moreover, you have the option to pay with any token and convert it to the group leader's preferred token. This enables combination transactions where you can use ETH as collateral, borrow GHO, and then convert and transfer the borrowed GHO back into ETH. This way, you can maintain full exposure to ETH while using GHO for payments.

For transaction processing, we bundle each payment in a custom protocol that leverages Chainlink's Cross-Chain Interoperability Protocol for cross-network transactions and a 1inch fork for token swapping. All transactions are securely signed with biometric authentication, and both the sender and receiver are notified upon completion.

Finally, the app's activity tab provides a history of your friends' transactions. This includes data from event logs of contracts, swaps, and transactions, as well as Aave facilitator activity, all accessible through the GraphQL subgraph endpoint.



# The GhoShare team
- [Jeevan Jutla](https://www.linkedin.com/in/jeevan-jutla/) - Backend Developer, prev Binance Security Engineer
- [Artemiy Malyshau](https://www.linkedin.com/in/artemiy-malyshau/) - Frontend Developer, Imperial CS and Engineering MSc 


 ![Solidity](https://img.shields.io/badge/Solidity-%23363636.svg?style=for-the-badge&logo=solidity&logoColor=white)
 ![TypeScript](https://img.shields.io/badge/typescript-%23007ACC.svg?style=for-the-badge&logo=typescript&logoColor=white)
 ![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
