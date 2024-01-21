# GhoShare

<p align="center">
  <img src="ghoshareimg.png" alt="Ghoshare Image" width="20%" height="auto"/>
</p>

An iOS app for easy expense splitting and settlement using credit delegation, cross-network transactions and token swapping. Secured by biometric authentication and EIP 4337 smart accounts.


# 👻 Main Features
- Secure and easy onboarding using Account Abstraction and EIP 4337 Smart Accounts
- Turnkey to generate signer wallet for smart account secured by FaceID authentication
- Aave V3 Ethereum Facilitator for minting of GHO on overcollateralized manner.
- Unlimit iOS SDK for adding crypto using fiat payments
- Pimlico paymaster and permissionless.js for smart contract deployment
- GHO facilitator activity shown using Ethereum Mainnet GraphQL subgraph endpoint
- Friends Transactions history shown from the event logs of contracts, swaps and transactions using historical balance.
- EIP 2612 Permit function to allow for signature based pre-approval of funds for expenses by the group leader.
- Credit Delegation Vault for Group Expense Management
- Custom payment protocol using Payment contracts, Chainlink CCIP for Cross-network transactions and 1inch fork for token swapping
- Notification alert to sender and receiver for confirmation of funds. 

# Images
<img src=https://github.com/nkoorty/lfgho/assets/80065244/c1dac0a9-789f-47cb-9d24-b28b56a1cef0 width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/183f4099-1d29-47d4-a9ef-2d6baced3723 width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/8a210690-05a2-498a-8238-7d975762d0e7 width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/0a486b77-0571-4212-a8f4-26f06b90c2bb width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/b64b5472-1e6b-4612-94bb-ddcdd9bf0996 width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/4cae5575-5be2-46a7-9a5f-846665297621 width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/56d43240-7a83-4fef-a4f7-161d19b0e59f width=12%>
<img src=https://github.com/nkoorty/lfgho/assets/80065244/61c29197-1a2d-40a2-8ca4-ea39cf97e6d0 width=12%>



# Home
### Expenses
The expenses tab is the users collection of groups for expense splitting. A [credit delegation vault](https://github.com/nkoorty/lfgho/blob/main/LFGHO-Web/contracts/ExpensesVault.sol) is used for expense splitting and settlement with Aave's GHO. Depositors can delegate their credit lines to other and has been adopted into a vault contract. Depositors provide liquididty for the expense to be paid by depositing assets like GHO into the Aave protocol. They can then delegate their credit lines to the vault contract which acts on behalf of the group for expense management. The vault acts as the borrower to borrow funds against the deposited collateral up to the delegated limit. 

The contract interats with Aave to borrow funds under the credit felegation feature. It can handle credit delegation from mutliple depositors. The borrowed funds can be used to settle payments of the groups expenses up front and the contract manages repayments  ensuring they are made on time to avoid liquidations. 

Users don’t have to lock up their capital. They can leverage their assets by borrowing against them, which could be more efficient for short-term expense management, offerng more flexibility in managing group expenses.

To manage the risk of credit delegation, particularly for the depositor you can only create groups with trusted friends and each borrower has score rating their interest and repayments so new friends can know how trustworthy they are.


# Activity




# Profile

# 👥 The GhoShare team
- [Jeevan Jutla](https://www.linkedin.com/in/jeevan-jutla/) - Backend Developer, prev Binance Security Engineer
- [Artemiy Malyshau](https://www.linkedin.com/in/artemiy-malyshau/) - Frontend Developer, Imperial CS and Engineering MSc 


 ![Solidity](https://img.shields.io/badge/Solidity-%23363636.svg?style=for-the-badge&logo=solidity&logoColor=white)
 ![TypeScript](https://img.shields.io/badge/typescript-%23007ACC.svg?style=for-the-badge&logo=typescript&logoColor=white)
 ![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
