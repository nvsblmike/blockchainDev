//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;
    uint256 public constant MINIMUM_USD = 50 *1e18;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Not enough money sent!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    modifier onlyOwner {
        require(msg.sender == i_owner, "Not the owner");
        _;
    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funders] = 0;
        }
        funders = new address[](0);
        (bool success, ) = payable(i_owner).call{ value: address(this).balance }("");

        require(success);
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}