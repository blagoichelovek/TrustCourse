// SCH Course Copyright Policy (C): DO-NOT-SHARE-WITH-ANYONE
// https://smartcontractshacking.com/#copyright-policy
pragma solidity ^0.8.13;

interface IReceiver {
    function getETH() external payable;
}

/**
 * @title Pool
 * @author JohnnyTime (https://smartcontractshacking.com)
 */
contract Pool {
    constructor() payable {}

    // TODO: Complete this function
    function flashLoan(uint256 amount) external {
        uint256 poolBalance = address(this).balance;
        require(poolBalance >= amount, "Not enough ETH in pool");
        IReceiver(msg.sender).getETH{value: amount}();
        uint256 balanceAfterCallback = address(this).balance;
        require(balanceAfterCallback >= poolBalance, "Flash loan hasn't been paid back");
    }

    receive() external payable {}
}