const { ethers } = require("hardhat");
const { METADATA_URL, WHITELIST_CONTRACT_ADDRESS } = require("../constant");

async function main() {
  // Address of the whitelist contract that i deployed @
  // https://github.com/Chiadikaobixo/my-solidity/tree/master/whitelist
  const whitelistContract = WHITELIST_CONTRACT_ADDRESS;
  // URL from where we can extract the metadata for a Cxo NFT
  const metadataURL = METADATA_URL;
  /*
  A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts.
  Here is a factory for instances of our Cxo NFT contract.
  */
  const cxoNftContract = await ethers.getContractFactory("CxoNft");

  // deploy the contract
  const deployedCxoNftContract = await cxoNftContract.deploy(
    metadataURL,
    whitelistContract
  );

  // print the address of the deployed contract
  console.log("Cxo Nft-Collection Contract Address:", deployedCxoNftContract.address);
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });