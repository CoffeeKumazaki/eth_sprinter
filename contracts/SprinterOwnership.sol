pragma solidity ^0.4.19;

import "./SprinterCompetition.sol";
import "../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721Basic.sol";

contract SprinterOwnership is SprinterCompetition, ERC721Basic {

    mapping(uint => address) sprinterApproval;


    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner != address(0), "invalid owner address");
        return ownerSprinterCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        address owner = sprinterOwner[_tokenId];
        require(owner != address(0), "invalid owner address");
        return owner;
    }

    function exists(uint256 _tokenId) public view returns (bool) {
        return sprinterOwner[_tokenId] != address(0);
    }


    function _transfer( address _from, address _to, uint256 _tokenId) private {

        require(ownerOf(_tokenId) == _from, "this sprinter is not owned by from address");

        sprinterOwner[_tokenId] = _to;
        ownerSprinterCount[_from] = ownerSprinterCount[_from].sub(1);
        ownerSprinterCount[_to] = ownerSprinterCount[_to].add(1);

        emit Transfer(_from, _to, _tokenId);
    }

    function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        _transfer(msg.sender, _to, _tokenId);
    }

    function approve( address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        sprinterApproval[_tokenId] = _to;
        emit Approval(msg.sender, _to, _tokenId);
    }



}