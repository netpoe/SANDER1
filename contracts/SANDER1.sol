pragma solidity ^0.4.24;

import './StandardToken.sol';
import './DetailedERC20.sol';

contract SANDER1 is StandardToken, DetailedERC20 {

    /**
    * 12 tokens equal 12 songs equal 1 album
    * uint256 supply
    */
    uint256 internal supply = 12 * 1 ether;

    constructor () 
        public 
        DetailedERC20 (
            "Super Ander Token 1",
            "SANDER1", 
            18
        ) 
    {
        totalSupply_ = supply;
        balances[msg.sender] = supply;
        emit Transfer(0x0, msg.sender, totalSupply_);
    }
}