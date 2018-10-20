pragma solidity ^0.4.19;

import "../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract SprinterFactory is Ownable {

    using SafeMath for uint256;

    event NewSprinter( uint sprinterId, string _name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10**dnaDigits;
    uint cooldownTime = 1 days;

    struct Sprinter {
        string  name;
        uint    dna;
        uint    trainNum;       // トレーニング回数
        uint    lastUpdate;     // 最新測定日
        uint32  breakTime;      // トレーニング休息終了時間
        uint32  bestScore;      // ベストスコア
        uint32  recentScore;    // 最新スコア
    }

    Sprinter[] sprinters;
    mapping (uint => address) public sprinterOwner;
    mapping (address => uint) public ownerSprinterCount;

    modifier ownerOf(uint _sprinterId) {
        require(msg.sender == sprinterOwner[_sprinterId], "this sprinter is not yours");
        _;
    }


    function _createSprinter( string _name, uint _dna) private {

        require(ownerSprinterCount[msg.sender]==0, "you already have some sprinters.");

        uint id = sprinters.push(Sprinter(_name, _dna, 0, 0, 0, 0, 0)) - 1;

        sprinterOwner[id] = msg.sender;
        ownerSprinterCount[msg.sender] = ownerSprinterCount[msg.sender].add(1);

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