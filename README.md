# Name of App
Submission for LFGHO Hackahton

# Main Features:
- Credit Delegation Vault for Group Expense management

# Home
### Expenses
The expenses tab is the users collection of groups for expense splitting. A [credit delegation vault](https://github.com/nkoorty/lfgho/blob/main/LFGHO-Web/contracts/ExpensesVault.sol) is used for expense splitting and settlement with Aave's GHO. Depositors can delegate their credit lines to other and has been adopted into a vault contract. Depositors provide liquididty for the expense to be paid by depositing assets like GHO into the Aave protocol. They can then delegate their credit lines to the vault contract which acts on behalf of the group for expense management. The vault acts as the borrower to borrow funds against the deposited collateral up to the delegated limit. 

The contract interats with Aave to borrow funds under the credit felegation feature. It can handle credit delegation from mutliple depositors. The borrowed funds can be used to settle payments of the groups expenses up front and the contract manages repayments  ensuring they are made on time to avoid liquidations. 

Users don’t have to lock up their capital. They can leverage their assets by borrowing against them, which could be more efficient for short-term expense management, offerng more flexibility in managing group expenses.

To manage the risk of credit delegation, particularly for the depositor you can only create groups with trusted friends and each borrower has score rating their interest and repayments so new friends can know how trustworthy they are.


# Activity




# Profile
