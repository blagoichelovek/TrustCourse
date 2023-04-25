// SCH Course Copyright Policy (C): DO-NOT-SHARE-WITH-ANYONE
// https://smartcontractshacking.com/#copyright-policy
pragma solidity ^0.8.13;

import "../interfaces/IPair.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "hardhat/console.sol";

/**
 * @title FlashSwap
 * @author JohnnyTime (https://smartcontractshacking.com)
 */
contract FlashSwap {

    IPair pair;
    address token;
    constructor(address _pair) {
        pair = IPair(_pair);
    }

    // TODO: Implement this function
    function executeFlashSwap(address _token, uint256 _amount) external {
        console.log("Contract's token balance before the flash swap", IERC20(_token).balanceOf(address(this)));

        //console.log("token 0:"pair.token0());
        //console.log("token 1:"pair.token1())
        
        
        
        
            token = _token;

        if(_token == pair.token0()){
            pair.swap(
                _amount,
                0,
                address(this),
                "0xAAAA"
                );
        } else if(_token == pair.token1()){
            pair.swap(
                0,
                _amount,
                address(this),
                "0xAAAA"
                );            
        } else{
            revert("Wrong token");
        }

        
    }

    // TODO: Implement this function
    function uniswapV2Call(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external {
        require(msg.sender == address(pair), "not pair");
        require(sender == address(this), "error");

        console.log("Contract's token balance during swap", IERC20(token).balanceOf(address(this)));

        uint256 fee;
        uint256 owed;
        if(pair.token0() == token){
            fee = amount0 * 3 / 997 + 1;
            owed = amount0 + fee;
        }else{
            ee = amount1 * 3 / 997 + 1;
            owed = amount1 + fee;
        }
        console.log("FlashSwap fee: ", fee);
        console.log("Owed:", owed);

        IERC20(token).transfer(address(pair), owed);

        

    }
}