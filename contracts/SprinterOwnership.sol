pragma solidity ^0.4.19;

import "./SprinterCompetition.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721Basic.sol";

contract SprinterOwnership is SprinterCompetition, ERC721Basic {

    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return ownerSprinterCount[_owner];
    }


    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        return sprinterOwner[_tokenId];
    }

}