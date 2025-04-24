// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BasicNFTMinter is ERC721URIStorage, Ownable {
    // Use a simple uint256 instead of Counters
    uint256 private _nextTokenId;
    
    // Optional: Minting fee configuration
    uint256 public mintingFee = 0.01 ether;
    bool public mintingFeeEnabled = false;
    
    // Optional: Max supply configuration
    uint256 public maxSupply = 10000;
    bool public maxSupplyEnabled = false;
    
    // Events
    event NFTMinted(address to, uint256 tokenId, string tokenURI);
    
    constructor(string memory name, string memory symbol) 
        ERC721(name, symbol) 
        Ownable(msg.sender) 
    {
        // Start token IDs at 1
        _nextTokenId = 1;
    }
    
    /**
     * @dev Mint a new NFT
     * @param to The recipient address
     * @param tokenURI The metadata URI for the NFT
     * @return The token ID of the newly minted NFT
     */
    function mintNFT(address to, string memory tokenURI) 
        public 
        payable 
        returns (uint256) 
    {
        // Check if max supply is enabled and not exceeded
        if (maxSupplyEnabled) {
            require(_nextTokenId <= maxSupply, "Max supply reached");
        }
        
        // Check if the minting fee is provided if enabled
        if (mintingFeeEnabled) {
            require(msg.value >= mintingFee, "Insufficient minting fee");
        }
        
        uint256 newTokenId = _nextTokenId;
        _nextTokenId += 1;
        
        _mint(to, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        
        emit NFTMinted(to, newTokenId, tokenURI);
        
        return newTokenId;
    }
    
    /**
     * @dev Mint an NFT to yourself (the sender)
     * @param tokenURI The metadata URI for the NFT
     * @return The token ID of the newly minted NFT
     */
    function selfMint(string memory tokenURI) 
        public 
        payable 
        returns (uint256) 
    {
        return mintNFT(msg.sender, tokenURI);
    }
    
    /**
     * @dev Owner-only function to mint an NFT without paying a fee
     * @param to The recipient address
     * @param tokenURI The metadata URI for the NFT
     * @return The token ID of the newly minted NFT
     */
    function ownerMint(address to, string memory tokenURI) 
        public 
        onlyOwner 
        returns (uint256) 
    {
        uint256 newTokenId = _nextTokenId;
        _nextTokenId += 1;
        
        _mint(to, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        
        emit NFTMinted(to, newTokenId, tokenURI);
        
        return newTokenId;
    }
    
    /**
     * @dev Set or update the minting fee
     * @param fee The new minting fee
     * @param enabled Whether the minting fee is enabled
     */
    function setMintingFee(uint256 fee, bool enabled) public onlyOwner {
        mintingFee = fee;
        mintingFeeEnabled = enabled;
    }
    
    /**
     * @dev Set or update the max supply
     * @param supply The new max supply
     * @param enabled Whether the max supply is enabled
     */
    function setMaxSupply(uint256 supply, bool enabled) public onlyOwner {
        maxSupply = supply;
        maxSupplyEnabled = enabled;
    }
    
    /**
     * @dev Withdraw the contract balance to the owner
     */
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No balance to withdraw");
        
        (bool success, ) = payable(owner()).call{value: balance}("");
        require(success, "Withdrawal failed");
    }
    
    /**
     * @dev Get the total number of NFTs minted so far
     * @return The total number of NFTs minted
     */
    function totalSupply() public view returns (uint256) {
        return _nextTokenId - 1;
    }
}