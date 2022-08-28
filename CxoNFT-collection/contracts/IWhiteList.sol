// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**
 * Interface for the whiteList contract at
 https://github.com/Chiadikaobixo/my-solidity/tree/master/whitelist
 */
interface IWhiteList {
    function whitelistedAddresses(address) external view returns (bool);
}