# Blockchain_project_kunal
Multi-Signature Wallet Implementation using Ethereum Smart Contracts

Validators cannot approve the same transaction twice
- Funds are released only after reaching the required approval threshold

---

# 🛠 Technology Stack

| Component | Technology |
|----------|------------|
| Smart Contract | Solidity |
| Development Tool | Remix IDE |
| Blockchain Network | Remix VM (Local Ethereum Network) |
| Wallet Accounts | Remix Pre-Funded Accounts |

---

# 🏗 System Architecture


Validator Nodes (10)
│
▼
Submit Transaction
│
▼
Validators Approve Transaction
│
▼
Approval Count ≥ 6
│
▼
Execute Transaction
│
▼
Funds Sent to Receiver


---

# 📜 Smart Contract Functions

## submitTransaction(address,uint256)

Creates a new transaction request.

### Example


submitTransaction(
0xReceiverAddress,
1000000000000000000
)


### Explanation

- `0xReceiverAddress` → receiver wallet
- `1000000000000000000` → **1 ETH in Wei**

Creates:


Transaction ID = 0


---

## approveTransaction(uint256)

Validators approve a transaction.

### Example


approveTransaction(0)


### Rules

- Only validator addresses can approve
- Each validator can approve **only once**

---

## executeTransaction(uint256)

Executes the transaction once the required approvals are reached.

### Example


executeTransaction(0)


---

## transactions(uint256)

Returns transaction information.

### Example


transactions(0)


### Output


to: receiver address
amount: 1000000000000000000
approvalCount: 6
executed: true


---

# ⚙ Step-by-Step Execution Guide

## Step 1 — Open Remix IDE

Open:


https://remix.ethereum.org


Create a file:


MultiSigWallet.sol


Paste the smart contract code.

---

## Step 2 — Compile the Contract

Open **Solidity Compiler**

Select version:


0.8.x


Click:


Compile MultiSigWallet.sol


Expected output:


Compilation Successful


---

## Step 3 — Deploy Contract

Open **Deploy & Run Transactions**

Environment:


Remix VM


Constructor parameters:


validators = [10 validator addresses]
requiredApprovals = 6


Set:


Value = 0


Click:


Deploy


Contract appears under **Deployed Contracts**.

---

## Step 4 — Fund the Contract

Before executing transactions the wallet must contain ETH.

Set:


Value = 5
Unit = ether


Click:


Transact


Contract balance becomes:


5 ETH


---

## Step 5 — Submit Transaction

Call:


submitTransaction(address,uint256)


Receiver:


0xAb8483F64d9C6d1EcF9b849Ae677dD3315835Cb2


Amount:


1000000000000000000


Transaction created:


Transaction ID = 0


---

## Step 6 — Validator Approvals

Approve transaction using validators.


Account1 → approveTransaction(0)
Account2 → approveTransaction(0)
Account3 → approveTransaction(0)
Account4 → approveTransaction(0)
Account5 → approveTransaction(0)
Account6 → approveTransaction(0)


Each approval increases:


approvalCount


---

## Step 7 — Automatic Execution

When approval count reaches:


6


The contract automatically executes:


executeTransaction()


Funds are transferred to the receiver.

---

## Step 8 — Verify Transaction

Call:


transactions(0)


Expected output:


approvalCount = 6
executed = true


---

# 💰 Account Balance Explanation

| Account | Role | Balance |
|-------|------|--------|
| Account 1 | Funded Contract | ~94.999 ETH |
| Account 2 | Receiver | ~100.999 ETH |
| Account 3–6 | Validators | ~99.999 ETH |
| Account 7–10 | Unused Accounts | 100 ETH |

---

# 📊 Transaction Logs (Remix Console)

Example log output:


status: Transaction mined and execution completed
transaction hash: 0xd1c2e648ba838f8376da6717d0be94e7df9de39b7238726fc51405af5509a6e0
block number: 45
transaction cost: 92697 gas
execution cost: 71505 gas


Logs confirm:

- Gas consumption
- Successful execution
- Contract state update

---

# ✅ Expected Output


Transaction ID: 0
Approval Count: 6
Executed: true

Contract Balance ↓
Receiver Balance ↑


---

# 🔒 Security Features

- Validators cannot approve twice
- Only authorized validators can approve
- Majority consensus required
- Prevents double execution

---

# 📌 Conclusion

The **Multi-Signature Wallet** ensures secure fund management by requiring **multiple validators to approve transactions**.

This mechanism:

- Prevents unauthorized transfers
- Ensures decentralized consensus
- Improves blockchain wallet security

---

# 👨‍💻 Author

**Project:** Multi-Signature Consensus Wallet  
**Technology:** Solidity + Remix IDE

⭐ If you like this project, consider giving it a **star on GitHub**!
