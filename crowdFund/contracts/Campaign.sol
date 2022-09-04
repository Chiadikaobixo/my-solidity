// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CampaignFactory {
    address[] public deployedCampaigns;

    function createCampaign(uint256 minimum) public {
        address newCampaign = address(new Campaign(minimum, msg.sender));
        deployedCampaigns.push(newCampaign);
    }

    function getDeployedCampaign() public view returns (address[] memory) {
        return deployedCampaigns;
    }
}

contract Campaign {
    struct Request {
        string description;
        uint256 value;
        address payable recipient;
        bool complete;
        uint256 approvalVoteCount;
        mapping(address => bool) voted;
    }

    Request[] public requests;
    address public manager;
    uint256 public minimumContribution;
    mapping(address => bool) public approvers;
    uint256 public approversCount;

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    constructor(uint256 minimum, address creator) {
        manager = creator;
        minimumContribution = minimum;
    }

    function contribute() public payable {
        require(msg.value >= minimumContribution);
        approvers[msg.sender] = true;
        approversCount++;
    }

    function createRequest(
        string memory description,
        uint256 value,
        address payable recipient
    ) public restricted {
        Request storage newRequest = requests.push();
        newRequest.description = description;
        newRequest.value = value;
        newRequest.recipient = recipient;
        newRequest.complete = false;
        newRequest.approvalVoteCount = 0;
    }

    function approveRequest(uint256 index) public {
        Request storage requestsCheck = requests[index];
        require(approvers[msg.sender]);
        require(!requestsCheck.voted[msg.sender]);

        requestsCheck.voted[msg.sender] = true;
        requestsCheck.approvalVoteCount++;
    }

    function finalizeRequest(uint256 index) public restricted {
        Request storage requestsCheck = requests[index];

        require(requestsCheck.approvalVoteCount > (approversCount / 2));
        require(!requestsCheck.complete);

        requestsCheck.recipient.transfer(requestsCheck.value);
        requestsCheck.complete = true;
    }

    function campaignDetails()
        public
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256,
            address
        )
    {
        return (
            address(this).balance,
            minimumContribution,
            requests.length,
            approversCount,
            manager
        );
    }

    function getRequestCount() public view returns(uint){
        return requests.length;
    }
}
