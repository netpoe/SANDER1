pragma solidity ^0.4.24;

import './CappedCrowdsale.sol';
import './SANDER1.sol';
import './SafeERC20.sol';

contract SuperCrowdsale is CappedCrowdsale {
    
    using SafeERC20 for SANDER1;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    address public owner;
    SANDER1 public token;
    uint256 internal weiAmount;

    event ProcessedRemainder(uint256 remainder);

    constructor (
        SANDER1 _token, // sander1.superander.eth
        address _wallet // wallet.superander.eth
    ) public 
        Crowdsale(
            _wallet,
            _token
        ) 
        CappedCrowdsale(
            217911580000000000000 // 217.91158 ETH
        ) 
    {
        owner = msg.sender;
        token = _token;
    }

    /**
   * @dev low level token purchase ***DO NOT OVERRIDE***
   * @param _beneficiary Address performing the token purchase
   */
    function buyTokens(address _beneficiary) public payable {
        weiAmount = msg.value;
        // if wei raised equals total cap, stop the crowdsale.
        _preValidatePurchase(_beneficiary, weiAmount);
        uint256 tokens = getTokenAmount(weiAmount);
        _processPurchase(_beneficiary, tokens);
        emit TokenPurchase(msg.sender, _beneficiary, weiAmount, tokens);
        _updatePurchasingState(_beneficiary, weiAmount);
        _forwardFunds();
        weiRaised = weiRaised.add(weiAmount);
        _postValidatePurchase(_beneficiary, weiAmount);
        weiAmount = 0;
    }

    /**
    * @dev Source of tokens. Override this method to modify the way in which the crowdsale ultimately gets and sends its tokens.
    * @param _beneficiary Address performing the token purchase
    * @param _tokenAmount Number of tokens to be emitted
    */
    function _deliverTokens(address _beneficiary, uint256 _tokenAmount) internal {
        token.safeTransferFrom(owner, _beneficiary, _tokenAmount);
    }

    /**
       * @dev Override to extend the way in which ether is converted to tokens.
       * @param _weiAmount Value in wei to be converted into tokens
       * @return Number of tokens that can be purchased with the specified _weiAmount
   */
    function getTokenAmount(uint256 _weiAmount) public view returns (uint256) {
        return _weiAmount.mul(token.allowance(owner, address(this))).div(cap);
    }
}