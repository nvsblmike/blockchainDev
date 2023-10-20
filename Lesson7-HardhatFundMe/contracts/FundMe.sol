//SPDX-License-Identifier: MIT
//1. pragma
pragma solidity ^0.8.17;
//2. imports
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

//3. interfaces, libraries, contracts
error FundMe_NotOwner();

/**
 * @title A sample Funding Contract
 * @author Alese Toluwani
 * @notice This contract is for creating a sample funding contract
 * @dev This implements price feeds as our library
 */
contract FundMe {
    //Type Declaration
    using PriceConverter for uint256;

    //State variables
    uint256 public constant MINIMUM_USD = 50 * 10 ** 18;
    address private immutable i_owner;
    address[] private s_funders;
    mapping(address => uint256) private s_addressToAmountFunded;
    AggregatorV3Interface private s_priceFeed;

    //Events(We have none!)
    //Modifiers
    modifier onlyOwner() {
        if(msg.sender != i_owner) revert FundMe_NotOwner();
        _;
    }

    /**
     * Fucntion Order:
     * constructor
     * receive
     * fallback
     * external 
     * public
     * internal
     * private
     * view/pure
     */

    constructor(address priceFeed) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    /**
     * @notice Funds our contract based on ETH/USD
     */
    function fund() public payable {
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "You need to spend more ETH");

        s_addressToAmountFunded[msg.sender] += msg.value;
        s_funders.push(msg.sender);
    }

    function withdraw() public onlyOwner {
        address[] memory funders = s_funders;
        
        for(uint256 i = 0; i < funders.length; i++) {
            s_addressToAmountFunded[funders[i]] = 0;
        }
        s_funders = new address[](0);
        (bool success, ) = payable(i_owner).call{value: address(this).balance}("");
        require(success);
    }

    /**
     * @notice Gets amount that an address has funded
     * @param fundingAddress the address of the funder
     * @return the amount funded
     */
    function getAddressToAmountFunded(address fundingAddress) public view returns(uint256) {
        return s_addressToAmountFunded[fundingAddress];
    }

    function getFunder(uint256 index) public view returns(address) {
        return s_funders[index];
    }
}