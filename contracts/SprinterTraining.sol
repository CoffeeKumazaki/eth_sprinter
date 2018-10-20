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

    KittyInterface kittyContract;

    // kittyによるトレーニング料.
    uint kittyTrainingFee = 0.001 ether;

    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }

    function setKittyTrainFee(uint _feeInEth) external onlyOwner {
        kittyTrainingFee = _feeInEth;
    }

    function _isReady( Sprinter storage _sprinter ) internal view returns (bool) {
        return (_sprinter.breakTime <= now);
    }

    function _train(uint _sprinterId, uint _trainerDna) private {

        Sprinter storage trainee = sprinters[_sprinterId];
        require(_isReady(trainee), "you are having breaking time");

        uint newDna = _trainerDna + trainee.dna;
        trainee.dna = newDna;
        trainee.breakTime = uint32(now + cooldownTime);

        trainee.trainNum = trainee.trainNum.add(1);
    }

    // Sprinter を使ったトレーニング.
    function trainWithSprinter( uint _sprinterId, uint _trainerId ) external ownerOf(_sprinterId) {

        Sprinter memory trainer = sprinters[_trainerId];
        _train(_sprinterId, trainer.dna);
    }

    // CryptoKitty を使ったトレーニング.
    // 有料だが、トレーニング効率10倍:TODO.
    function trainWithKitty( uint _sprinterId, uint _kittyId ) external payable ownerOf(_sprinterId) {

        require(msg.value >= kittyTrainingFee, "your payment is not enough");

        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        
        _train(_sprinterId, kittyDna);
    }
}