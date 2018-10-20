pragma solidity ^0.4.19;

import "./SprinterFactory.sol";


contract KittyInterface {
    function getKitty(uint _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
        );
}

contract SprinterTraining is SprinterFactory {

    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract = KittyInterface(ckAddress);

    function _train(uint _sprinterId, uint _trainerDna) private {

        Sprinter storage trainee = sprinters[_sprinterId];
        uint newDna = _trainerDna + trainee.dna;
        trainee.dna = newDna;

        trainee.trainNum = trainee.trainNum.add(1);
    }

    // Sprinter を使ったトレーニング.
    function trainSprinterWith( uint _sprinterId, uint _trainerId ) public {

        require(msg.sender == sprinterOwner[_sprinterId], "this sprinter is not yours");

        Sprinter memory trainer = sprinters[_trainerId];
        _train(_sprinterId, trainer.dna);
    }

    // CryptoKitty を使ったトレーニング.
    // トレーニング効率10倍:TODO.
    function runawayFromKitty( uint _sprinterId, uint _kittyId ) public {

        require(msg.sender == sprinterOwner[_sprinterId], "this sprinter is not yours");

        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        
        _train(_sprinterId, kittyDna);
    }
}