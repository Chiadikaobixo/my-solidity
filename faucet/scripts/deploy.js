const { ethers } = require("hardhat");

async function main() {
  /*
  A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts,
  so faucetContract here is a factory for instances of the Faucet contract.
  */
  const faucetContract = await ethers.getContractFactory("Faucet");

  // here we deploy the contract
  const deployedFaucetContract = await faucetContract.deploy();
  // 10 is the Maximum number of whitelisted addresses allowed
  
  // Wait for it to finish deploying
  await deployedFaucetContract.deployed();

  // print the address of the deployed contract
  console.log(
    "Faucet Contract Address:",
    deployedFaucetContract.address
  );
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });