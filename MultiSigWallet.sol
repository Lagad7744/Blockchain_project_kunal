// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiSigWallet {

    address[] public validators;
    uint public requiredApprovals;

    struct Transaction {
        address to;
        uint amount;
        bool executed;
        uint approvalCount;
    }

    Transaction[] public transactions;

    mapping(address => bool) public isValidator;
    mapping(uint => mapping(address => bool)) public approvals;

    constructor(address[] memory _validators, uint _requiredApprovals) {

        require(_validators.length == 10, "Need exactly 10 validators");
        require(_requiredApprovals <= _validators.length, "Invalid approval count");

        for(uint i=0;i<_validators.length;i++){
            address validator = _validators[i];
            validators.push(validator);
            isValidator[validator] = true;
        }

        requiredApprovals = _requiredApprovals;
    }

    modifier onlyValidator(){
        require(isValidator[msg.sender], "Not validator");
        _;
    }

    function submitTransaction(address _to, uint _amount) public onlyValidator {

        transactions.push(Transaction({
            to: _to,
            amount: _amount,
            executed: false,
            approvalCount: 0
        }));
    }

    function approveTransaction(uint txId) public onlyValidator {

        Transaction storage txn = transactions[txId];

        require(!txn.executed, "Already executed");
        require(!approvals[txId][msg.sender], "Already approved");

        approvals[txId][msg.sender] = true;
        txn.approvalCount++;

        if(txn.approvalCount >= requiredApprovals){
            executeTransaction(txId);
        }
    }

    function executeTransaction(uint txId) public {

        Transaction storage txn = transactions[txId];

        require(!txn.executed, "Already executed");
        require(txn.approvalCount >= requiredApprovals, "Not enough approvals");

        txn.executed = true;

        payable(txn.to).transfer(txn.amount);
    }

    receive() external payable {}

}