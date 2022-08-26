// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IWhiteList.sol";

/** @dev is ERC721Enumerable keep track of all the tokenIds and tokensIds in the contract */
contract CxoNft is ERC721Enumerable, Ownable {
    /**  @dev _baseTokenURI for computing {tokenURI}. If set, the resulting URI for each
      * token will be the concatenation of the `baseURI` and the `tokenId`.
    */
    string _baseTokenURI;

    //  _price is the price of one Cxo NFT
    uint256 public _price = 0.001 ether;

    // paused is used to pause the contract in case of an emergency
    bool public _paused;

    // max number of Cxo NFT
    uint256 public maxTokenIds = 30;

    // total number of tokenIds minted
    uint256 public tokenIds;

    // Whitelist contract instance
    IWhiteList whitelist;

    // boolean to keep track of whether presale started or not
    bool public presaleStarted;

    // timestamp for when presale would end
    uint256 public presaleEnded;

    // checks to make sure the contract is not paused
    modifier onlyWhenNotPaused() {
        require(!_paused, "this Contract is currently paused");
        _;
    }

    /**
     * @dev ERC721 constructor takes in a `name` and a `symbol` to the token collection.
     * name in our case is `CxoNft` and symbol is `Cxo`.
     * Constructor takes in the baseURI to set _baseTokenURI for the collection.
     * It also initializes an instance of whitelist interface.
     */
    constructor(string memory baseURI, address whitelistContract)
        ERC721("CxoNft", "Cxo")
    {
        _baseTokenURI = baseURI;
        whitelist = IWhiteList(whitelistContract);
    }

    /** @dev starts presale for all whitelisted addresses */
    function startsPresale() public onlyOwner {
        presaleStarted = true;
        //  Set presaleEnded time as current timestamp + 10 minutes
        presaleEnded = block.timestamp + 10 minutes;
    }

    /** @dev presaleMint allows a user to mint one NFT per transaction during the presale */
    function presaleMint() public onlyWhenNotPaused payable{
        require(presaleStarted && block.timestamp < presaleEnded, "presale has not started");
        require(whitelist.whitelistedAddresses(msg.sender), "You are not whiteListed");
        require(tokenIds < maxTokenIds, "Total Cxo supply exceeded");
        require(msg.value >= _price, "Not enough ETH for this transaction");
        tokenIds += 1;

        //  mints to the users address
        _safeMint(msg.sender, tokenIds);
    }

    /** @dev mint allows a user to mint one NFT after the presale has ended */
    function mint() public onlyWhenNotPaused payable{
        require(presaleStarted && block.timestamp > presaleEnded, "presale has ended");
        require(tokenIds < maxTokenIds, "Total Cxo supply exceeded");
        require(msg.value >= _price, "Not enough ETH for this transaction");
        tokenIds += 1;

        //  mints to the users address
        _safeMint(msg.sender, tokenIds);
    }
    
    /** @dev  _baseURI overides the Openzeppelin's ERC721 implementation which by default
     *  returned an empty string for the baseURI
    */
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    /** @dev  setPaused makes the contract paused or unpaused */
    function setPaused(bool val) public onlyOwner {
        _paused = val;
    }

    /** @dev withdraw send all the eth in the contract to the owner of the contract */
    function withdraw()public onlyOwner{
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent,) = _owner.call{value: amount}("");
        require(sent, "Transaction Failed");
    }

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
}