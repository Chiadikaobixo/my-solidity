// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract lottery {
    // address of the manager
    address public manager;
    // Array of address of entered players
    address[] public players;
    // Address of the last winner
    address public lastWinner;

    constructor() {
        manager = msg.sender;
    }

    /** 
      *@dev Add players to the lottery
    */
    function addPlayer() public payable{
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }

    /** 
      *@dev helper function that generate random numbers
    */
    function random() private view returns (uint){
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }

    /** 
      *@dev pickWinner picks a random address as the winner
    */
    function pickWinner() public restricted{
        uint index = random() % players.length;
        // transfers the winning prize to the winner
        payable(players[index]).transfer(address(this).balance);
        // updates lastWinner to be the address of the winner
        lastWinner = players[index];
        // Empty players array for new draw
        players = new address[](0);
    }

    /** 
      *@dev A modifier that makes sure a function
      * is only called by the owner of the lottery
    */
    modifier restricted(){ 
        require(msg.sender == manager);
        _;
    }

    /** 
      *@dev get players return players 
    */
    function getPlayers() public view returns (address[] memory ){
        return players;
    }
}