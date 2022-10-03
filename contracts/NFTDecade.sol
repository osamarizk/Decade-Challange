// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
// Import Openzeppline Contract in order to safe contract minting
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//import openzippline Ownerable to apply Authorization of specific functions
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTDecade is ERC721URIStorage,Ownable{
// define state variables
    uint256 public nftPrice=0.001 ether; // nft price
    uint256 public totalSupply; //  total supplay
    uint256 public maxSupply; // Max contract supply
    bool public isMintEnabled; // to enable or disable minting

    mapping(address =>uint256)public NftMintedToWallet; // track minting to each wallet

    constructor() ERC721("NFT Decade","NFTDEC") {
        maxSupply=4; // initial contract supply value

    }

    function toggleMintEnabbled() external onlyOwner {
        isMintEnabled=!isMintEnabled; //enable minting
    }

    function setMaxSupply(uint256 maxSupply_) external onlyOwner {
        maxSupply=maxSupply_; // change contract supply

    }

    function setNftPrice(uint256 nftPrice_) external onlyOwner {
        nftPrice=nftPrice_; //change nft price
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/QmTG3rjoyCJE3XJ6XaYte8pQkwzxta2fpNgaZhMVBjfLuG/";
    }

    function mintNFT() external payable {
        require(isMintEnabled , "Mint not enabled"); // check if minitng is enable?
        require(maxSupply>totalSupply ,"Sold Out"); //check if the bot still have NFT or not
        require(NftMintedToWallet[msg.sender]<1 , "Minted Before"); //check if the wallet minted before?
        require(msg.value==nftPrice , "invalid value"); //check the provided value to nft price
        NftMintedToWallet[msg.sender]++; // save the minted nft to user
        totalSupply++; // increase total supply
        uint256 tokenId=totalSupply; //define token id
        _safeMint(msg.sender, tokenId); //start minting

    }
    


}