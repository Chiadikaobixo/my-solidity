const { ethers } = require("hardhat");

async function main() {
  /*
  A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts,
  so BankContract here is a factory for instances of our Bank contract.
  */
  const bankContract = await ethers.getContractFactory("Bank");

  // here we deploy the contract
  const deployedBankContract = await bankContract.deploy();
  
  // Wait for it to finish deploying
  await deployedBankContract.deployed();

  // print the address of the deployed contract
  console.log(
    "Bank Contract Address:",
    deployedBankContract.address
  );
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });