//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage {
    //Basic solidity types
    //bool isFavouriteNumber = true;
    //uint256 favouriteNumber = 5;
    //string favouriteNumberInText = "Five";
    //bytes32 favNumberInIDK = "cat";
    //address myAddress = 0x788bAFda4D147f6e9686ad763414F7651d97Eb28;
    uint256 favouriteNumber;
    struct People {
        uint256 favouriteNumber;
        string name;
    }

    People[] public people;
    mapping(string => uint256) nameToFavouriteNumber;

    function store(uint256 _favouriteNumber) public virtual{
        favouriteNumber = _favouriteNumber;
    }

    function retrieve() public view returns(uint256) {
        return favouriteNumber;
    }

    function addPerson(uint256 _favouriteNumber, string memory _name) public {
        people.push(People(_favouriteNumber, _name));
        nameToFavouriteNumber[_name] = _favouriteNumber;
    }
}
 