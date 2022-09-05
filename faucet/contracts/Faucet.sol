// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Libraries/SafeMaths.sol";

contract Faucet is Ownable {
    using SafeMath for uint256;
    // Array of the addresses that have donated to the faucet.
    address[] public donators;
    // Amount of eth to dispense
    uint256 public amount = 0.1 ether;
    // Amount to donate
    uint256 public donate = 0.3 ether;
    // The total amount that a particular address has donated to the Faucet.
    mapping(address => uint256) public funders;
    // Total amount that a particular address has collected from the Faucet.
    mapping(address => uint256) public collections;
    // The last time a particular address withdrew from the faucet
    mapping(address => uint256) public time;
    // Lock time of an address 
    mapping(address => uint256) public lockTime;

    // The following two functions allow the contract to accept ETH deposits
    // directly from a wallet without calling a function
    receive() external payable {}

    fallback() external payable {}

    constructor() payable {}

    /** 
     * @dev Checks if the address has donated to the faucet.
     */    
    function donatedAddress(address _address) public view returns (bool) {
        // length of the donators array.
        uint256 length = donators.length;

        // Loop over the array
        for (uint256 i = 0; i < length; i++) {
            // If the address exists in the array.
            if (donators[i] == _address)
                return true;
        }

        // if the donor is not in the array.
        return false;
    }

    /**
     * @dev addressBalance returns the balance of the contract
     */
    function addressBalance() public view onlyOwner returns (uint256) {
        return address(this).balance;
    }

    /** 
     * @dev resets the amount of eth to be dispensed
     */
    function setAmountallowed(uint256 newAmount) public onlyOwner {
        amount = newAmount;
    }

    /** 
     * @dev function to donate funds to the faucet contract
     */
    function donateTofaucet() public payable {
        require(msg.value >= donate, "Not enough eth");
        // sets the amount an address has donated to the faucet
        (, uint256 k) = funders[msg.sender].add(donate);
        funders[msg.sender] = k;

        // If the address has not donated before, it should be added to the donators array.
        if (!donatedAddress(msg.sender)) {
            // Add the address to the array.
            donators.push(msg.sender);
        }
    }

    /** 
     * @dev function to send tokens from faucet to an address
     */
    function requestTokens(address payable requestor) public payable {
        //perform a few checks to make sure function can execute
        require(
            block.timestamp > lockTime[owner()],
            "You can't request at this time Please try again later"
        );
        require(address(this).balance > amount, "Not enough funds");

        // Update the collections of the requester.
        (, uint256 j) = collections[requestor].add(amount);
        collections[requestor] = j;
        // Update the last request time.
        time[msg.sender] = block.timestamp;

        //if the balance of this contract is greater then the requested amount send funds
        requestor.transfer(amount);

        //updates locktime 10 hours from now
        lockTime[msg.sender] = block.timestamp + 10 hours;
    }
}
