//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256 _simpleStorageNumber) {
        _simpleStorageNumber = simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}