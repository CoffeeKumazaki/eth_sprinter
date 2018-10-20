pragma solidity ^0.4.19;

import "./SprinterFactory.sol";


contract KittyInterface {
    function getKitty() external view returns (
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

    // Sprinter を使ったトレーニング.
    function trainSprinterWith( uint _sprinterId, uint _trainerId ) public {

        require(msg.sender == sprinterOwner[_sprinterId], "this sprinter is not yours");

        Sprinter storage trainee = sprinters[_sprinterId];
        Sprinter memory  trainer = sprinters[_trainerId];

        uint newDna = trainee.dna + trainer.dna + 1;

        trainee.trainNum = trainee.trainNum.add(1);
        trainee.dna = newDna;
    }

    // CryptoKitty を使ったトレーニング.
    function runawayFromKitty( uint _sprinterId ) public {

        
    }
}