# my-solidity

## 1. Lottery   
Manager deploys the contract   
Users can enter the contract for draw   

[Deployed contract on Rinkeby Etherscan.](https://rinkeby.etherscan.io/address/0x0E10F5026b0fb0a61C04B585A68e4EE533149fd4 "lottery")    

## 2. CrowdFund
Allows a user (manager) to create an instance of the campaign.             
Anyone can contribute to the campaign.             
Only the manager can create a request for the campaign.                 
Only the contributors of a particular campaign can vote for the approval the campaign request.   
Only the manager can finalize the request if the total number of approval is morethan the average number of the contributors of the campaign.   

[Deployed contract on Rinkeby Etherscan.](https://rinkeby.etherscan.io/address/0xd345e035EBE32995ffD14292ED1D1630B94d3E26 "crowdFund")    

## 3. Faucet   
Faucet is a Smart Contracts that dispenses tokens to users upon request.       

[Deployed contract on Goerli Etherscan.](https://goerli.etherscan.io/address/0x47a75D5Fc9f3ce643147Bf5856626045f242603e "faucet")      

## 4. ERC-20
This is a simple ERC-20 token smart contract that allows you to create your own token on the Ethereum blockchain. ERC-20 is the technical standard for fungible tokens created using the Ethereum blockchain and it allows different smart-contract enabled tokens a way to be exchanged.    

[Deployed contract on Goerli Etherscan.](https://goerli.etherscan.io/address/0xd0965aB6d8E1284dC4381412cd1c90143f477D10 "Chiadi ERC-20") 

## 5. WhiteList
Owner of the contract deploys the contract.  
First 10 users get whitelisted for presale access.  

[Deployed contract on Goerli Etherscan.](https://goerli.etherscan.io/address/0x3C151f33823b7a2a51f2Bb3A0ac20224F19f3B8A "whitelist") 

## 6. CxoNFT-collection
Owner of CxoNFT deploys the contract.   
Owner of the deployed contract starts the presale.   
Whitelisted addresses have access to presale mint.   
Any address has access to the public mint once presale has ended.     
Owner of the deployed contract can withdraw from the contract.   

[Mint CxoNFT](https://cxo-nft-collection.vercel.app "CxNFT")   
[View CxoNFT on Opensea](https://testnets.opensea.io/collection/cxonft-4lbagqgwro "CxNFT")   

[Deployed contract on Goerli Etherscan.](https://goerli.etherscan.io/address/0x71F202923383B02c98C48618Dd3f18Df97A283df "CxoNFT-collection")    

## 7. DAO   
#### Decentralized Autonomous Organization for CXO holders     
Owner of the DAO deploys the contract.      
Anybody with CXONft can be able create a proposal to purchase a different NFT from an NFT marketplace.    
Everyone with a CXONFT can vote for or against the active proposals.    
Each NFT counts as one vote for each proposal.     
Voters cannot vote multiple times on the same proposal with the same NFT.        
If majority of the voters vote for the proposal by the deadline, the owners of CXONFT can executed proposal.    

[Deployed contract on Goerli Etherscan.](https://goerli.etherscan.io/address/0xf5c7c0e02bBDE1d5606C5FA092F9E8D670E07B8b "DAO")     

## 8. Ethereum Bank
#### Ethereum bank is a smart contract bank, you can think of it as a normal bank but it operates on ether.     

This is a smart contract that allows a user to create an account with the Ethereum Bank. A bytes32 password is required for the account creation, the password will be hashed off-chain, and then set onchain.      
1. users can withdraw ethereum at any point in time in respect to their account balance        
2. users are eligible for a one time interest of their total account balance, this is only available to users who have not debited their account in the pass 100 days. newly created account must be up to 100 days before being aligible for interest       
3. interest differs to different users, in respect to their account status    
4. users can deposit to their ethereum bank account     
5. users can transfer eth to other users of the ethereum bank     
6. users can do an inter tranfer from their ethereum bank account to a user ethereum address     
7. users can change their account password      

### account status    
#### Savings Account    
0.1 ether minimum deposit and eligible for 2% interest rate    

#### Current Account    
0.5 ether minimum deposit and eligible for 3% interest rate    

#### Off-shore Account   
10 ether minimum deposit and eligible for 5% interest rate   

[Deployed contract on Goerli Etherscan.](https://goerli.etherscan.io/address/0x45aa685e3788C79C7529c16C7215e772BA47E2A1 "bank")    

## 9. Chain Link Data Feed 
Chainlink Data Feeds are the quickest way to connect your smart contracts to the real-world data. They act as bridges between blockchains and the external world. However it is important to note that the blockchain oracle is not itself the data source but its job is to query, verify and authenticate the outside data and then futher pass it to the smart contract. This contract uses the AggregatorV3Interface in the Chainlink Oracle to get the real-time market price of      
ETH - USD     
BTC - ETH    
BTC - USD    

[Deployed contract on Goerli Etherscan.](https://goerli.etherscan.io/address/0x4e7078835822B2c5E50AC82d4B7c93c8B98197e1 "Data Feed")    

## 10. NFT Marketplace
This is an NFT marketplace that allows a user to perform the basic function of a marketplace.     
A user can be able to       
- mint non-fungible tokens (NFTs)     
- list non-fungible tokens (NFTs)  
- Sell and buy listed non-fungible tokens (NFTs)
- Fetch market Items
- Fetch purchased NFTs etc.   

This marketplace requires a one time listing fee of 0.01 ether for minted nft and bought nft.       

[Deployed contract on Goerli Etherscan.](https://goerli.etherscan.io/address/0x352510eBa4A0E64Da46Fa083f4C1Dd6591093375 "Nft Marketplace") 