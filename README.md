# Decentralized Star Notary

This project,will create a DApp by adding functionality to smart contract and deploy it on the public testnet. This dApp provides facility for starNotary which can be used to claim stars and sell the same. This uses NFT ERC721 EIP token.  
This project uses **OpenZeppelin**(https://github.com/OpenZeppelin/openzeppelin-solidity) open source solidity library which help us to achieve our ERC721 Notary contract ready without much worry of implementing functionality which are related to ERC721,so that we can focus on our project logic and use case API.  

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.  

### Prerequisites

Installing Node and NPM is pretty straightforward using the installer package available from the (Node.js® web site)[https://nodejs.org/en/].  

### Configuring project

- Copy attached files from finaProj.zip under current dir(you may create new dir and copy there server.js and change dir to the new dir before running below mentioned commands  
...

- Use NPM to download package.json based project dependencies.  
...
cd smart_contracts;  
npm update ; (this will update all required node modules dependecies for the project)  
```

## Testing

To test code:  
1: Install Metamask plugin for chrome and get Rinkeby test network ether for the metamask account.  
2: Open the attached index.html file in chrome browser ( where metamask is installed and have got Rinkeby account with valid ether for test network )and put all values in string and toeknID int and call the createStar button   
3: To check starInfo which was just created you can call GetStarInfo which will return just created star   
4: To test other public method you may use https://remix.ethereum.org and point metamask account which has ether for Rinkeby test network  
5: Load the contract at address metnioned **0x6a0e25bc7c42e4df558c8dfc3bd4fa405586d4e6** it would load all API  
6: You can check the API after calling the createStar or use other API to sell star  
7: Check any method preset there and you can verify the trasaction on the etherscan for rinkeby.
8: In case any issue please contact me at atullh@gmail.com
```
