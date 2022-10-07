const { ethers } = require("hardhat");

async function main() {
  /*
  A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts,
  so marketPlaceContract here is a factory for instances of our marketPlace contract.
  */
  const marketPlaceContract = await ethers.getContractFactory("marketPlace");

  // here we deploy the contract
  const deployedMarketPlaceContract = await marketPlaceContract.deploy();
  
  // Wait for it to finish deploying
  await deployedMarketPlaceContract.deployed();

  // print the address of the deployed contract
  console.log(
    "marketPlace Contract Address:",
    deployedMarketPlaceContract.address
  );
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });