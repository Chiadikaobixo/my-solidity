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

## 4. ERC-20
This is a simple ERC-20 token smart contract that allows you to create your own token on the Ethereum blockchain. ERC-20 is the technical standard for fungible tokens created using the Ethereum blockchain and it allows different smart-contract enabled tokens a way to be exchanged.    

[Deployed contract on Rinkeby Etherscan.](https://rinkeby.etherscan.io/address/0xF78e51b0F9b58B2D5bc47FF7227f40eD609352A2 "Chiadi ERC-20") 

## 5. WhiteList
Owner of the contract deploys the contract.  
First 10 users get whitelisted for presale access.  

[Deployed contract on Rinkeby Etherscan.](https://rinkeby.etherscan.io/address/0x4b5a54b2EbC2247B1B397346fFd705dDc0f9741f "whitelist") 

## 6. CxoNFT-collection
Owner of CxoNFT deploys the contract.   
Owner of the deployed contract starts the presale.   
Whitelisted addresses have access to presale mint.   
Any address has access to the public mint once presale has ended.     
Owner of the deployed contract can withdraw from the contract.   

[Mint CxoNFT](https://cxo-nft-collection.vercel.app "CxNFT")   
[View CxoNFT on Opensea](https://testnets.opensea.io/collection/cxonft-v2 "CxNFT")   

[Deployed contract on Rinkeby Etherscan.](https://rinkeby.etherscan.io/address/0x664E672487B1067492B101d2179864acAE02a991 "CxoNFT-collection")    

## 7. DAO   
#### Decentralized Autonomous Organization for CXO holders     
Owner of the DAO deploys the contract.      
Anybody with CXONft can be able create a proposal to purchase a different NFT from an NFT marketplace.    
Everyone with a CXONFT can vote for or against the active proposals.    
Each NFT counts as one vote for each proposal.     
Voters cannot vote multiple times on the same proposal with the same NFT.        
If majority of the voters vote for the proposal by the deadline, the owners of CXONFT can executed proposal.    

[Deployed contract on Rinkeby Etherscan.](https://rinkeby.etherscan.io/address/0x29F911C9E55d5f63bFF57402633889D0d6a60e6e "DAO")     


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

[Deployed contract on Rinkeby Etherscan.](https://rinkeby.etherscan.io/address/0xFe0c402D5Ef218d6edEde5fFE23e43B71c444CeA "bank")    