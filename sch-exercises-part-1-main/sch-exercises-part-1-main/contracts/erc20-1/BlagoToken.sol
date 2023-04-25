// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract BlagoiToken is ERC20{
address public owner;

constructor () ERC20("BlagoiToken", "BTT"){
    owner = msg.sender;
}

function mint(address _to, uint256 _amount) external {
    require(msg.sender == owner, "NOT AN OWNER");
    _mint(_to, _amount);

}

}