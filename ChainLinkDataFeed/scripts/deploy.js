const { ethers } = require("hardhat");

async function main() {
  /*
  A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts,
  so dataFeedContract here is a factory for instances of our DataFeed contract.
  */
  const dataFeedContract = await ethers.getContractFactory("DataFeed");

  // here we deploy the contract
  const deployedDataFeedContract = await dataFeedContract.deploy();
  
  // Wait for it to finish deploying
  await deployedDataFeedContract.deployed();

  // print the address of the deployed contract
  console.log(
    "DataFeed Contract Address:",
    deployedDataFeedContract.address
  );
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });