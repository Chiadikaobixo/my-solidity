// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**
 * Minimal interface for CxoNFT 
 * @ https://github.com/Chiadikaobixo/CxoNFT-collection/blob/main/contracts/CxoNft.sol 
 * containing only two functions
 * that i am interested in.
 */
interface ICxoNFT {
    /// @dev balanceOf returns the number of NFTs owned by the given address
    /// @param owner - address to fetch number of NFTs for
    /// @return Returns the number of NFTs owned
    function balanceOf(address owner) external view returns (uint256);

    /// @dev tokenOfOwnerByIndex returns a tokenID at given index for owner
    /// @param owner - address to fetch the NFT TokenID for
    /// @param index - index of NFT in owned tokens array to fetch
    /// @return Returns the TokenID of the NFT
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);
}