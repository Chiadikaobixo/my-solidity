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
Faucet dispenses tokens to users upon request.       

[Deployed contract on Rinkeby Etherscan.](https://rinkeby.etherscan.io/address/0xD4C3563dCACD1f37B638D1b00F6a5b5F5E9dcF07 "faucet")      

## 4. WhiteList
Owner of the contract deploys the contract.  
First 10 users get whitelisted for presale access.  

[Deployed contract on Rinkeby Etherscan.](https://rinkeby.etherscan.io/address/0x4b5a54b2EbC2247B1B397346fFd705dDc0f9741f "whitelist") 

## 5. CxoNFT-collection
Owner of CxoNFT deploys deploys the contract.   
Owner of the deployed contract starts the presale.   
Whitelisted addresses have access to presale mint.   
Any address has access to the public mint once presale has ended.     
Owner of the deployed contract can withdraw from the contract.   

[Mint CxoNFT](https://cxo-nft-collection.vercel.app "CxNFT")   
[View CxoNFT on Opensea](https://testnets.opensea.io/collection/cxonft-v2 "CxNFT")   

[Deployed contract on Rinkeby Etherscan.](https://rinkeby.etherscan.io/address/0x664E672487B1067492B101d2179864acAE02a991 "CxoNFT-collection")    

## 6. DAO   
#### Decentralized Autonomous Organization for CXO holders     
Owner of the DAO deploys the contract.      
Anybody with CXONft can be able create a proposal to purchase a different NFT from an NFT marketplace.    
Everyone with a CXONFT can vote for or against the active proposals.    
Each NFT counts as one vote for each proposal.     
Voters cannot vote multiple times on the same proposal with the same NFT.        
If majority of the voters vote for the proposal by the deadline, the owners of CXONFT can executed proposal.    

[Deployed contract on Rinkeby Etherscan.](https://rinkeby.etherscan.io/address/0x29F911C9E55d5f63bFF57402633889D0d6a60e6e "DAO")     