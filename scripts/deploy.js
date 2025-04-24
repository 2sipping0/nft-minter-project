const hre = require("hardhat");

async function main() {
  // Get the contract factory
  const BasicNFTMinter = await hre.ethers.getContractFactory("BasicNFTMinter");
  
  // Deploy the contract with name and symbol parameters
  const nftMinter = await BasicNFTMinter.deploy("MyNFTCollection", "MNFT");
  
  // Wait for deployment to complete
  // In newer versions we use deploymentTransaction().wait() instead of deployed()
  await nftMinter.waitForDeployment();
  
  // Get the deployed contract address
  const address = await nftMinter.getAddress();
  
  console.log("NFT Minter deployed to:", address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });