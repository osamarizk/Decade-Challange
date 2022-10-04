// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
// Import Openzeppline Contract in order to safe contract minting
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//import openzeppline Ownerable to apply Authorization of specific functions
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTDecade is ERC721URIStorage,Ownable{
// define state variables
    uint256 public nftPrice; // nft price
    uint256 public supply; //  total supplay
    uint256 public maxSupply; // Max contract supply
    bool public isMintEnabled; // to enable or disable minting

    mapping(address =>uint256)public NftMintedToWallet; // track minting to each wallet

    constructor(uint256 _maxSupply, uint _nftPrice) ERC721("NFT Decade","NFTDEC") {
        maxSupply= _maxSupply; // initial contract supply value
        maxSupply= _nftPrice; // initial nft price

    }

    function toggleMintEnabbled() external onlyOwner {
        isMintEnabled = !isMintEnabled; //enable minting
    }

    function changeMaxSupply(uint256 maxSupply_) external onlyOwner {
        maxSupply = maxSupply_; // change contract supply

    }

    function changeNftPrice(uint256 nftPrice_) external onlyOwner {
        nftPrice = nftPrice_; //change nft price
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/QmTG3rjoyCJE3XJ6XaYte8pQkwzxta2fpNgaZhMVBjfLuG/";
    }

    function mintNFT() external payable {
        require(isMintEnabled, "Mint not enabled"); // check if minitng is enable?
        require(maxSupply > supply ,"Sold Out"); //check if the bot still have NFT or not
        require(NftMintedToWallet[msg.sender] < 1 , "Minted Before"); //check if the wallet minted before?
        require(msg.value == nftPrice , "invalid value"); //check the provided value to nft price
        NftMintedToWallet[msg.sender]++; // save the minted nft to user
        uint256 tokenId = supply; //define token id
        supply++; // increase total supply
        _safeMint(msg.sender, tokenId); //start minting

    }

}