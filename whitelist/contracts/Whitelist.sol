// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Whitelist {
    // Max number of whitelisted addresses allowed
    uint8 public maxWhitelistedAddresses;

    // Create a mapping of whitelistedAddresses
    // if an address is whitelisted, we would set it to true, it is false by default for all other addresses.
    mapping(address => bool) public whitelistedAddresses;

    // numAddressesWhitelisted would be used to keep track of how many addresses have been whitelisted
    // NOTE: Don't change this variable name, as it will be part of verification
    uint8 public numAddressesWhitelisted;

    // Address of the manager that deployed the contract
    address public owner;

    // Moderator mapping
    mapping(address => bool) public moderators;

    // Setting the Max number of whitelisted addresses
    // User will put the value at the time of deployment
    constructor(uint8 _maxWhitelistedAddresses) {
        maxWhitelistedAddresses = _maxWhitelistedAddresses;
        // Set the owner address.
        owner = msg.sender;
        // Add owner to the moderators.
        moderators[msg.sender] = true;
    }

    /*
     * @dev
     * Control function to make sure that only an owner or an admin can call a particular function.
     */
    function isAdmin() internal view returns (bool) {
        return ((msg.sender == owner) || (moderators[msg.sender] == true));
    }

    /**
        addAddressToWhitelist - This function adds the address of the sender to the
        whitelist
     */
    function addAddressToWhitelist() public {
        // check if the user has already been whitelisted
        require(!whitelistedAddresses[msg.sender]);
        // check if the numAddressesWhitelisted < maxWhitelistedAddresses, if not then throw an error.
        require(numAddressesWhitelisted < maxWhitelistedAddresses);
        // Add the address which called the function to the whitelistedAddress array
        whitelistedAddresses[msg.sender] = true;
        // Increase the number of whitelisted addresses
        numAddressesWhitelisted += 1;
    }

    /**
        removeAddressToWhitelist - This function removes the address from the
        whitelist
     */
    function removeAdressFromWhitelist(address wAddress) public {
        // only the admin or a moderator can call thos function.
        require(isAdmin(), "Not owner or moderator");
        // removes the address which called the function to the whitelistedAddress array
        whitelistedAddresses[wAddress] = false;
        // decrease the number of whitelisted addresses
        numAddressesWhitelisted -= 1;
    }

    // add an array of addresses to whitelist
    function addArrayOfAddressToWhiteList(address[] memory ArrayAddress)
        public
    {
        // only the admin or a moderator can call thos function.
        require(isAdmin(), "Not owner or moderator");

        // length of the array
        uint256 arrayLength = ArrayAddress.length;

        // loop through the array, add and increment number of addresses
        for (uint256 i = 0; i < arrayLength; i++) {
            // check if the array of user has already been whitelisted
            require(!whitelistedAddresses[ArrayAddress[i]]);
            whitelistedAddresses[ArrayAddress[i]] = true;
            numAddressesWhitelisted += 1;
        }
    }
}
