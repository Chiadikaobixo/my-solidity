// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/ICxoNFT.sol";
import "../interfaces/IFakeNFTMarketplace.sol";

contract DAO is Ownable {
    IFakeNFTMarketplace nftMarketplace;
    ICxoNFT cxoNft;

    struct Proposal {
        // describes the purpose of the proposal
        string purpose;
        // nftTokenId - the tokenID of the NFT to purchase from FakeNFTMarketplace if the proposal passes
        uint256 nftTokenId;
        // deadline - the UNIX timestamp until which this proposal is active. Proposal can be executed after the deadline has been exceeded.
        uint256 deadline;
        // yesVotes - number of yes votes for this proposal
        uint256 yesVotes;
        // noVotes - number of no votes for this proposal
        uint256 noVotes;
        // executed - whether or not this proposal has been executed yet. Cannot be executed before the deadline has been exceeded.
        bool executed;
        // voters - a mapping of CxoNFT tokenIDs to booleans indicating whether that NFT has already been used to cast a vote or not
        mapping(uint256 => bool) voters;
    }

    // enum containing possible options for a vote
    enum Vote {
        YES,
        NO
    }

    // Mapping of ID to Proposal
    mapping(uint256 => Proposal) public proposals;
    // Number of proposals that have been created
    uint256 public numProposals;

    /**
     * @dev cxoNftHoldersOnly is a modifier that allows a function to be called only by those
     * who owns at least 1 CxoNft
     */
    modifier cxoNftHoldersOnly() {
        require(cxoNft.balanceOf(msg.sender) > 0, "NOT A DAO MEMBER");
        _;
    }

    /**
     * @dev activeProposalOnly is a modifier which only allows a function to be
     * called if the given proposal's deadline has not been exceeded yet
     */
    modifier activeProposalOnly(uint256 proposalIndex) {
        require(
            proposals[proposalIndex].deadline > block.timestamp,
            "DEADLINE_EXCEEDED"
        );
        _;
    }

    /**
     * @dev inactiveProposalOnly is a modifier which only allows a function to be
     * called if the given proposal's deadline HAS been exceeded
     * and if the proposal has not yet been executed
     */
    modifier inactiveProposalOnly(uint256 proposalIndex) {
        require(
            proposals[proposalIndex].deadline <= block.timestamp,
            "DEADLINE_NOT_EXCEEDED"
        );
        require(
            proposals[proposalIndex].executed == false,
            "PROPOSAL_ALREADY_EXECUTED"
        );
        _;
    }

    /**
     * @dev Creates a payable constructor which initializes the contract instances
     * for FakeNFTMarketplace and CxoNFT and allows this constructor
     * to accept an ETH deposit when it is being deployed
     */
    constructor(address fakeNft, address cxo) payable {
        nftMarketplace = IFakeNFTMarketplace(fakeNft);
        cxoNft = ICxoNFT(cxo);
    }

    // The following two functions allow the contract to accept ETH deposits
    // directly from a wallet without calling a function
    receive() external payable {}

    fallback() external payable {}

    /**
     * @dev createProposal allows a CxoNFT holder to create a new proposal in the DAO
     * @param tokenId - the tokenID of the NFT to be purchased from FakeNFTMarketplace if this proposal passes
     * @param description - describes the purpose of the proposal
     * @return Returns the proposal index for the newly created proposal
     */
    function _createProposal(uint256 tokenId, string memory description)
        external
        cxoNftHoldersOnly
        returns (uint256, string memory)
    {
        require(nftMarketplace.available(tokenId), "NFT_NOT_FOR_SALE");
        Proposal storage proposal = proposals[numProposals];
        proposal.nftTokenId = tokenId;
        proposal.purpose = description;
        // Set the proposal's voting deadline to be (current time + 5 minutes)
        proposal.deadline = block.timestamp + 5 minutes;

        // increases the total number of the proposal
        numProposals++;

        return (tokenId, description);
    }

    /**
     * @dev _voteOnProposal allow only cxoNftHolder's to vote on active proposal
     * @param proposalIndex - the index of the proposal to vote on in the proposals array
     * @param vote - the type of vote a user want to cast
     */
    function _voteOnProposal(uint256 proposalIndex, Vote vote)
        external
        cxoNftHoldersOnly
        activeProposalOnly(proposalIndex)
    {
        Proposal storage proposal = proposals[proposalIndex];

        uint256 voterNFTBalance = cxoNft.balanceOf(msg.sender);
        uint256 numVotes = 0;

        // It calculates how many NFTs are owned by the voter that
        // haven't already been used for voting on this proposal
        for (uint256 i = 0; i < voterNFTBalance; i++) {
            console.log(cxoNft.tokenOfOwnerByIndex(msg.sender, i));
            uint256 tokenId = cxoNft.tokenOfOwnerByIndex(msg.sender, i);
            if (proposal.voters[tokenId] == false) {
                numVotes++;
                proposal.voters[tokenId] = true;
            }
        }
        require(numVotes > 0, "ALREADY_VOTED");

        if (vote == Vote.YES) {
            proposal.yesVotes += numVotes;
        } else {
            proposal.noVotes += numVotes;
        }
    }

    /**
     * @dev _executeProposal allows any cxoNFT holder to execute a proposal after it's deadline has been exceeded
     * @param proposalIndex - the index of the proposal to execute in the proposals array
     */
    function _executeProposal(uint256 proposalIndex)
        external
        cxoNftHoldersOnly
        inactiveProposalOnly(proposalIndex)
    {
        Proposal storage proposal = proposals[proposalIndex];

        // purchase the NFT from the FakeNFTMarketplace if
        // the proposal has more YES votes than NO votes
        if (proposal.yesVotes > proposal.noVotes) {
            uint256 nftPrice = nftMarketplace.getPrice();
            require(address(this).balance >= nftPrice, "NOT_ENOUGH_FUNDS");
            nftMarketplace.purchase{value: nftPrice}(proposal.nftTokenId);
        }
        proposal.executed = true;
    }

    /**
     * @dev _withdrawEther allows the owner of the contract (ie the deployer) to
     * withdraw the ETH from the contract
     */
    function _withdrawEther() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    /**
     * @dev nftBalance gets the CxoNft balance of the caller
     */
    function nftBalance() public view  returns(uint) {
        return cxoNft.balanceOf(msg.sender);
    }
}
