const HDWalletProvider = require("@truffle/hdwallet-provider");
const Web3 = require("web3");
require("dotenv").config();
const { abi, evm } = require('./compile')

const provider = new HDWalletProvider({
  mnemonic: {
    phrase: process.env.MNEMONICPHRASE
  },
  providerOrUrl: process.env.RINKEBY_URL
  });

const web3 = new Web3(provider);

const deploy = async () => {
    // Get a list of all account
    fetchedAccounts = await web3.eth.getAccounts()
    console.log('Attempting to deploy from account', fetchedAccounts[0])

    deployedResult = await new web3.eth.Contract(abi)
        .deploy({ data: evm.bytecode.object })
        .send({ from: fetchedAccounts[0], gas: '1000000' })

        console.log('Contract ABI', JSON.stringify(abi))
        console.log('Contract deployed to', deployedResult.options.address)
        provider.engine.stop()
}
deploy()