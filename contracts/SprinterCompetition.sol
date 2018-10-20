pragma solidity ^0.4.19;

import "./SprinterHelper.sol";

contract SprinterCompetition is SprinterHelper {


    uint randNonce = 0;

    function _randMod( uint _modulus ) internal returns (uint) {

        randNonce = randNonce.add(1);
        if (_modulus == 0) {
            return 0;
        }
        else {
            return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
        }
    }

    function sprint( uint _sprinterId) external ownerOf(_sprinterId) {

        Sprinter storage mySprinter = sprinters[_sprinterId];

        mySprinter.lastUpdate = now;
        uint32 score = 0; // TODO

        mySprinter.recentScore = score;
        if ( score > mySprinter.bestScore ){
            mySprinter.bestScore = score;
        }

    }

}