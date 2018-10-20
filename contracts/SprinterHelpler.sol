pragma solidity ^0.4.19;
import "./SprinterTraining.sol";

contract SprinterHelper is SprinterTraining {

    function changeName( uint _sprinterId, string _newName) external {
        
        require(sprinterOwner[_sprinterId] == msg.sender, "this sprinter is not yours");
        Sprinter storage sprinter = sprinters[_sprinterId];

        sprinter.name = _newName;        
    } 

    function getSprinterByOwner( address _owner ) external view returns(uint[]){
        uint[] memory results = new uint[](ownerSprinterCount[_owner]);

        uint count = 0;
        for (uint index = 0; index < sprinters.length; index++) {

            if ( sprinterOwner[index] == _owner ) {
                results[count] = index;
                count = count.add(1);
            }
        }

        return results;
    }

}