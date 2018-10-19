pragma solidity ^0.4.19;

contract SprinterFactory {

    event NewSprinter( uint sprinterId, string _name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10**dnaDigits;

    struct Sprinter {
        string name;
        uint dna;
    }

    Sprinter[] sprinters;
    mapping (uint => address) public sprinterOwner;
    mapping (address => uint) public ownerSprinterCount;

    function _createSprinter( string _name, uint _dna) private {

        require(ownerSprinterCount[msg.sender]==0, "you already have some sprinters.");

        uint id = sprinters.push(Sprinter(_name, _dna)) - 1;

        sprinterOwner[id] = msg.sender;
        ownerSprinterCount[msg.sender]++;

        emit NewSprinter(id, _name, _dna);
    }

    function _getRandomDna( string _str ) private view returns (uint) {
        uint rand = uint(keccak256(bytes(_str)));
        return rand % dnaModulus;
    }

    function createSprinter( string _name ) public {
        uint randDna = _getRandomDna(_name);
        _createSprinter(_name, randDna);
    }

}