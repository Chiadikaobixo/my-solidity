const { ethers } = require("hardhat");
const { CXONFT_COLLECTION_CONTRACT_ADDRESS } = require("../constant");

async function main() {
    // Deploy the FakeNFTMarketplace contract first
    const FakeNFTMarketplace = await ethers.getContractFactory(
        "FakeNFTMarketplace"
    );
    const fakeNftMarketplace = await FakeNFTMarketplace.deploy();
    await fakeNftMarketplace.deployed();

    console.log("FakeNFTMarketplace deployed to: ", fakeNftMarketplace.address);

    // Deploy the DAO contract
    const DAO = await ethers.getContractFactory("DAO");
    const dao = await DAO.deploy(
        fakeNftMarketplace.address,
        CXONFT_COLLECTION_CONTRACT_ADDRESS,
        {
            value: ethers.utils.parseEther("0.01"),
        }
    );
    await dao.deployed();

    console.log("DAO deployed to: ", dao.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });