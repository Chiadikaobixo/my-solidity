const { ethers } = require("hardhat");

async function main() {
    /*
    A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts,
    so ChiadiContract here is a factory for instances of our Chiadi contract.
    */
    const chiadiContract = await ethers.getContractFactory("Chiadi");

    // here we deploy the contract
    const deployedChiadiContract = await chiadiContract.deploy();
    // 10 is the Maximum number of whitelisted addresses allowed

    // Wait for it to finish deploying
    await deployedChiadiContract.deployed();

    // print the address of the deployed contract
    console.log(
        "Chaidi Contract Address:",
        deployedChiadiContract.address
    );
}

// Call the main function and catch if there is any error
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });