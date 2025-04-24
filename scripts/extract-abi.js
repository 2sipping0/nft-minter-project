const fs = require('fs');
const path = require('path');

// Path to the compiled contract JSON
const contractPath = path.join(
  __dirname,
  '../artifacts/contracts/BasicNFTMinter.sol/BasicNFTMinter.json'
);

// Read the contract JSON
const contractJson = require(contractPath);

// Extract just the ABI
const abi = contractJson.abi;

// Create the destination directory if it doesn't exist
const destDir = path.join(__dirname, '../frontend/src/abis');
if (!fs.existsSync(destDir)) {
  fs.mkdirSync(destDir, { recursive: true });
}

// Write the ABI to a new file
fs.writeFileSync(
  path.join(destDir, 'BasicNFTMinter.json'),
  JSON.stringify(abi, null, 2)
);

console.log('ABI extracted successfully!');
