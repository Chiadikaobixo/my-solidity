// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTMarketplace is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    Counters.Counter private _itemsSold;

    // amount required to put an nft up for sale on the marketplace
    uint256 listingPrice = 0.01 ether;
    address payable owner;
    // mapping of uint to NftDetails
    mapping(uint256 => NftDetails) public nftIdToNftDetails;
    // mapping of address to boolean
    mapping(address => bool) public oneTimeListingFee;
    // mapping of address to boolean
    mapping(address => bool) public oneTimeSellingFee;

    // struct of each nft
    struct NftDetails {
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    event MarketItemCreated(
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );

    modifier onlyOwner() {
        require(owner == msg.sender, "Not owner of the marketplace");
        _;
    }

    constructor() ERC721("CXONFT", "Cxo") {
        owner = payable(msg.sender);
    }

    /*
     * @dev getListingPrice Returns the amount required to list an nft
     * in the marketplace
     */
    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }

    /*
     * @dev UpdateListingPrice updates the amount required in other to list an nft in the
     *  marketplace. This function can only be called by the owner of the contract
     */
    function updateListingPrice(uint256 _listingPrice)
        public
        payable
        onlyOwner
    {
        listingPrice = _listingPrice;
    }

    /**
     * @dev mintToken mints an nft
     */
    function mintToken(string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        //   _mint() internal function is used to mint a new NFT at the given address. (msg.sender)
        _mint(msg.sender, newTokenId);
        //   _setTokenURI() Internal function to set the token URI for a given token
        _setTokenURI(newTokenId, tokenURI);
        return newTokenId;
    }

    /**
     * @dev listNftforSale this function puts up minted nft for sale in the marketplace
     * an it requires a one time listing fee
     */
    function listNftforSale(uint256 tokenId, uint256 price) public payable {
        // runs if it is a bought nft. then it will require a one
        // time listing fee for bought nft's
        if (nftIdToNftDetails[tokenId].sold == true) {
            listBoughtToken(tokenId, price);
            return;
        }
        require(price > 0, "Price must be at least 1 wei");
        // runs if an address have not listed an nft before
        if (oneTimeListingFee[msg.sender] == false) {
            require(
                msg.value == listingPrice,
                "Price must be equal to listing price"
            );
        }

        // updates details of the listed nft
        nftIdToNftDetails[tokenId] = NftDetails(
            tokenId,
            payable(msg.sender),
            payable(address(this)),
            price,
            false
        );

        // tranfers token to the nftmarketplace contract
        _transfer(msg.sender, address(this), tokenId);

        emit MarketItemCreated(
            tokenId,
            msg.sender,
            address(this),
            price,
            false
        );
        // changes the satues of `msg.sender` to be an address that have listed an nft
        oneTimeListingFee[msg.sender] = true;
    }

    /**
     * @dev buyListedNft: This function executes the buying of an nft from the marketplace
     * and transfers ownership of the item, as well as funds between parties
     */
    function buyListedNft(uint256 tokenId) public payable {
        uint256 price = nftIdToNftDetails[tokenId].price;
        address seller = nftIdToNftDetails[tokenId].seller;
        require(seller != msg.sender, "you cant buy your own nft");
        require(msg.value == price, "Please submit the asking price");
        nftIdToNftDetails[tokenId].owner = payable(msg.sender);
        nftIdToNftDetails[tokenId].sold = true;
        nftIdToNftDetails[tokenId].seller = payable(address(0));
        _itemsSold.increment();
        // transfers nft to the buyers address
        _transfer(address(this), msg.sender, tokenId);
        payable(owner).transfer(listingPrice);
        payable(seller).transfer(msg.value);
    }

    /*
     * @dev listBoughtToken allows a user to list and
     * resell a token they have purchased
     */
    function listBoughtToken(uint256 tokenId, uint256 price) public payable {
        require(
            nftIdToNftDetails[tokenId].owner == msg.sender,
            "Only item owner can perform this operation"
        );
        // runs if an address have not listed Bought nft before
        if (oneTimeSellingFee[msg.sender] == false) {
            require(
                msg.value == listingPrice,
                "Price must be equal to listing price"
            );
        }
        nftIdToNftDetails[tokenId].sold = false;
        nftIdToNftDetails[tokenId].price = price;
        nftIdToNftDetails[tokenId].seller = payable(msg.sender);
        nftIdToNftDetails[tokenId].owner = payable(address(this));
        _itemsSold.decrement();

        // tranfers token to the nftmarketplace contract
        _transfer(msg.sender, address(this), tokenId);
        // changes the satues of `msg.sender` to be an address that have listed bought nft
        oneTimeSellingFee[msg.sender] = true;
    }

    /*
     * @dev fetchMarketItems returns all unsold nfts
     */
    function fetchMarketItems() public view returns (NftDetails[] memory) {
        uint256 itemCount = _tokenIds.current();
        uint256 unsoldItemCount = _tokenIds.current() - _itemsSold.current();
        uint256 currentIndex = 0;

        NftDetails[] memory items = new NftDetails[](unsoldItemCount);
        for (uint256 i = 0; i < itemCount; i++) {
            if (nftIdToNftDetails[i + 1].owner == address(this)) {
                uint256 currentId = i + 1;
                NftDetails storage currentItem = nftIdToNftDetails[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }

    /*
     * @dev fetchPurchasedNFTs Returns only items that a user has purchased
     */
    function fetchPurchasedNFTs() public view returns (NftDetails[] memory) {
        uint256 totalItemCount = _tokenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalItemCount; i++) {
            if (nftIdToNftDetails[i + 1].owner == msg.sender) {
                itemCount += 1;
            }
        }

        NftDetails[] memory items = new NftDetails[](itemCount);
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (nftIdToNftDetails[i + 1].owner == msg.sender) {
                uint256 currentId = i + 1;
                NftDetails storage currentItem = nftIdToNftDetails[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }

    /*
     * @dev fetchItemsListed Returns only items a user has listed in the marketplace
     */
    function fetchItemsListed() public view returns (NftDetails[] memory) {
        uint256 totalItemCount = _tokenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for (uint256 i = 0; i < totalItemCount; i++) {
            if (nftIdToNftDetails[i + 1].seller == msg.sender) {
                itemCount += 1;
            }
        }

        NftDetails[] memory items = new NftDetails[](itemCount);
        for (uint256 i = 0; i < totalItemCount; i++) {
            if (nftIdToNftDetails[i + 1].seller == msg.sender) {
                uint256 currentId = i + 1;
                NftDetails storage currentItem = nftIdToNftDetails[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
    }
}
