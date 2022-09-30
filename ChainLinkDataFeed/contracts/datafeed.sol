// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract DataFeed {
    AggregatorV3Interface internal ETH2USD;
    AggregatorV3Interface internal BTC2ETH;
    AggregatorV3Interface internal BTC2USD;
    
    /**
     * @dev Initializes the Goerli Testnet proxy 
     * for the ETH / USD
     * BTC / ETH
     * BTC / USD
    */
    constructor() {
        ETH2USD = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        BTC2ETH=AggregatorV3Interface(0x779877A7B0D9E8603169DdbD7836e478b4624789);
        BTC2USD=AggregatorV3Interface(0xA39434A63A52E749F02807ae27335515BA4b07F7);
    }
    
    /**
     @dev returns the price of ethereum to usd
    */
    function getEth2USD() public view returns (int $){
        (
           ,
           int256 answer,
           ,
           ,
           
        ) = ETH2USD.latestRoundData();
        // scale down the answer by 10 ** 8 in order to get price in USD
        $ = answer / 1e8;
        return $;
    }
    /**
     @dev returns the price of BTC to Ethereum
    */
    function getBTC2ETH() public view returns (int Eth){
        (
           ,
           int256 answer,
           ,
           ,
           
        ) = BTC2ETH.latestRoundData();
        // scale down the answer by 10 ** 18 in order to get price in ETH
        Eth = answer / 1e18;
        return Eth;
    }

    /**
     @dev returns the price of ethereum to usd
    */
    function getBTC2USD() public view returns (int $){
        (
           ,
           int256 answer,
           ,
           ,
           
        ) = BTC2USD.latestRoundData();
        // scale down the answer by 10 ** 8 in order to get price in USD
        $ = answer / 1e8;
        return $;
    }
}
