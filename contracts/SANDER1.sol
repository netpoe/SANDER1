pragma solidity ^0.4.21;

import '../node_modules/openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol';
import '../node_modules/openzeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol';

contract SANDER1 is StandardToken, DetailedERC20 {

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