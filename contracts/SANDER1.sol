pragma solidity ^0.4.24;

import './StandardToken.sol';
import './DetailedERC20.sol';

contract SANDER1 is StandardToken, DetailedERC20 {

    /**
    * 10 tokens equal 10 songs equal 1 album
    * uint256 supply
    */
    uint256 internal supply = 10 * 1 ether;

    constructor () 
        public 
        DetailedERC20 (
            "Súper Ánder Token 1", 
            "SANDER1", 
            18
        ) 
    {
        totalSupply_ = supply;
        balances[msg.sender] = supply;
        emit Transfer(0x0, msg.sender, totalSupply_);
    }
}