pragma solidity 0.8.19;
import './Tether.sol';
import './Reward.sol';

contract DecentralBank {

    string public name="Decentral Bank";
    address public owner;
    Tether public tether;
    Reward public reward;

    address[] public stakers;

    mapping(address=>uint) stakingBalance;
    mapping(address=>bool) hasStacked;
    mapping(address=>bool) isStacking;

    constructor (Tether _tether,Reward _reward)public{
        tether=_tether;
        reward=_reward;
    }

    // staking function
    function depositTokens(uint _amount) public{
        // Transfer Tether tokens to this address for staking
        tether.transferFrom(msg.sender, address(this), _amount);

        if(!hasStacked[msg.sender]){
            stakers.push(msg.sender);
        }

        // Update staking balance
        hasStacked[msg.sender]=true;
        isStacking[msg.sender]=true;
    }

}