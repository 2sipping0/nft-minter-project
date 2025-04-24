# NFT Minter Project

A basic decentralized application (dApp) for creating and minting NFTs (Non-Fungible Tokens) on the Ethereum blockchain using Solidity smart contracts and a React frontend.

## Overview

This project provides a complete solution for minting NFTs with:
- Solidity smart contract (ERC-721 compliant)
- React-based frontend interface
- Integration with MetaMask wallet
- IPFS metadata storage support

## Features

- Mint NFTs directly from the web interface
- Connect with MetaMask wallet
- Configure optional minting fees
- Set maximum supply limits
- Store NFT metadata on IPFS
- Owner-only administrative functions

## Technology Stack

- **Smart Contracts**: Solidity, OpenZeppelin, Hardhat
- **Frontend**: React, ethers.js
- **Wallet Connection**: MetaMask
- **Metadata Storage**: IPFS (via Pinata or NFT.Storage)

## Project Structure

```
nft-minter-project/
├── contracts/           # Smart contract code
│   └── BasicNFTMinter.sol
├── scripts/             
│   └── deploy.js        # Deployment scripts
    └── extract-abi.js   # Extract ABIs
├── metadata/            # NFT metadata files
│   ├── assets/          # NFT images/assets
│   └── [token-id].json  # Metadata JSON files
├── frontend/            # React application
│   ├── src/
│   │   ├── abis/        # Contract ABIs
│   │   ├── components/  # React components
│   │   ├── utils/       # Utility functions
│   │   └── App.js
│   └── public/
├── hardhat.config.js    # Hardhat configuration
└── .env                 # Environment variables (not in repo)
```

## Prerequisites

- Node.js (v14+)
- npm or yarn
- MetaMask browser extension
- IPFS account (Pinata or NFT.Storage)

## Installation

1. Clone the repository:
   ```bash
   git clone [repository-url]
   cd nft-minter-project
   ```

2. Install dependencies:
   ```bash
   # Install backend dependencies
   npm install
   
   # Install frontend dependencies
   cd frontend
   npm install
   cd ..
   ```

3. Create a `.env` file in the root directory:
   ```
   INFURA_API_KEY=your_infura_api_key
   PRIVATE_KEY=your_wallet_private_key
   ```

## Smart Contract Deployment

1. Compile the contract:
   ```bash
   npx hardhat compile
   ```

2. Deploy to a local network:
   ```bash
   # Start a local node in one terminal
   npx hardhat node
   
   # Deploy in another terminal
   npx hardhat run scripts/deploy.js --network localhost
   ```

3. Deploy to a testnet (e.g., Goerli):
   ```bash
   npx hardhat run scripts/deploy.js --network goerli
   ```

4. Copy the deployed contract address for your frontend.

## Frontend Setup

1. Create the ABI directory and copy the contract ABI:
   ```bash
   mkdir -p frontend/src/abis
   cp artifacts/contracts/BasicNFTMinter.sol/BasicNFTMinter.json frontend/src/abis/
   ```

2. Update the contract address in `frontend/src/App.js`:
   ```javascript
   const contractAddress = '0xYourContractAddress';
   ```

3. Start the frontend development server:
   ```bash
   cd frontend
   npm start
   ```

4. The application should now be running at [http://localhost:3000](http://localhost:3000)

## Creating and Uploading NFT Metadata

1. Create JSON metadata for your NFT:
   ```json
   {
     "name": "My NFT #1",
     "description": "This is my first NFT",
     "image": "ipfs://QmYourImageCID",
     "attributes": [
       {
         "trait_type": "Background",
         "value": "Blue"
       },
       {
         "trait_type": "Eyes",
         "value": "Green"
       }
     ]
   }
   ```

2. Upload your NFT image to IPFS using Pinata or NFT.Storage.

3. Update the metadata JSON with your image CID.

4. Upload the metadata JSON to IPFS.

5. Use the metadata CID as the tokenURI when minting (format: `ipfs://QmMetadataCID`).

## Using the dApp

1. Open your browser and navigate to [http://localhost:3000](http://localhost:3000).

2. Connect your MetaMask wallet using the "Connect Wallet" button.

3. Enter the IPFS URI of your metadata (format: `ipfs://QmMetadataCID`).

4. Click "Mint NFT" to create your NFT.

5. Confirm the transaction in MetaMask.

## Administrative Functions

Contract owners have access to additional functions:

- Set or update minting fees
- Enable/disable minting fees
- Set or update maximum supply
- Withdraw funds collected from minting fees

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- OpenZeppelin for secure contract libraries
- Hardhat for the Ethereum development environment
- React for the frontend framework
- ethers.js for blockchain interaction