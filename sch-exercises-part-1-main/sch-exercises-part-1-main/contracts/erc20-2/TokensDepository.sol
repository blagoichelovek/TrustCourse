// SPDX-License-Identifier: GPL-3.0-or-later 
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {rToken} from "./rToken.sol";

/**
 * @title TokensDepository
 * @author JohnnyTime (https://smartcontractshacking.com)
 */
contract TokensDepository {
    mapping(address => IERC20) public tokens;
    mapping(address => rToken) public receiptTokens;


    modifier isSupported(address _token){
        require(address(tokens[_token]) != address(0), "token is not supported");
        _;
    }

    constructor(address _aave, address _uni, address _weth){
        tokens[_aave] = IERC20(_aave);
        tokens[_uni] = IERC20(_uni);
        tokens[_weth] = IERC20(_weth);

        receiptTokens[_aave] = new rToken(_aave, "Receipt AAVE", "rAAVE");
        receiptTokens[_uni] = new rToken(_uni, "Receipt UNI", "rUNI");
        receiptTokens[_weth] = new rToken(_weth, "Receipt WETH", "rWETH");
    }
    

    function deposit(address _token, uint256 _amount) external isSupported(_token){
        bool success = tokens[_token].transferFrom(msg.sender, address(this), _amount);
        require(success, "transferFrom failed");

        receiptTokens[_token].mint(msg.sender, _amount);
    }

    function withdraw(address _token, uint256 _amount) external isSupported(_token){
        receiptTokens[_token].burn(msg.sender, _amount);

        bool success = tokens[_token].transfer(msg.sender, _amount);
        require(success, "transfer failed");

    }
}
