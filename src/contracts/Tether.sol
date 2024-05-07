pragma solidity ^0.8.19;

contract Tether {
    string public name = "Mock Tether Token";
    string public symbol = "mUSDT";
    uint256 public totalSupply = 1000000000000000000000000;
    uint8 public decimals = 18;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint _value
    );

    event Approval(
        address _owner,
        address _sender,
        uint _value
    );

    mapping(address=>uint256) public balanceOf;
    mapping(address=>mapping(address=>uint256)) public allowance;

    constructor() public {
        balanceOf[msg.sender]=totalSupply;
    } 

    function transfer(address _to,uint256 _value)public returns(bool){
        // Balance of sender should be sufficient for transfer
        require(balanceOf[msg.sender]>=_value);
        // Subtract amount from sender
        balanceOf[msg.sender]-=_value;
        // Add amount to the receiver
        balanceOf[_to]+=_value;
        emit Transfer(msg.sender,_to,_value);
        return true;
    }

    function approve(address _spender,uint256 _value)public returns (bool success){
        allowance[msg.sender][_spender]=_value;
        emit Approval(msg.sender,_spender,_value);
        return true;
    }

    function transferFrom(address _from,address _to,uint256 _value)public returns(bool){
        require(balanceOf[msg.sender]>=_value);
        require(allowance[_from][msg.sender]>=_value);

        balanceOf[_to]+=_value;
        balanceOf[_from]-=_value;

        allowance[_from][msg.sender]-=_value;
        allowance[_to][msg.sender]+=_value;

        emit Transfer(_from,_to,_value);
        return true;
    }

}
