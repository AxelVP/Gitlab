// SPDX-License-Identifier: Unlicenced

pragma solidity 0.8.26;

contract TokenContract {

    address public owner;
    struct Receivers {
        string name;
        uint256 tokens;
    }
    mapping(address => Receivers) public users;

    modifier onlyOwner(){require(msg.sender == owner);
        _;
    }

    constructor(){
        owner = msg.sender;
        users[owner].tokens = 100;
    }

    function double(uint _value) public pure returns (uint){
        return _value*2;
    }

    function register(string memory _name) public{
        users[msg.sender].name = _name;
    }

    function giveToken(address _receiver, uint256 _amount) onlyOwner public{
        require(users[owner].tokens >= _amount);
        users[owner].tokens -= _amount;
        users[_receiver].tokens += _amount;
    }

    function compraTokens() public payable {
        uint256 comprarTokens = msg.value / 5 ether;
        require(comprarTokens > 0, "No tienes ether para comprar tokens");
        require(users[owner].tokens >= comprarTokens, "No hay tokens suficientes para vender");

        users[owner].tokens -= comprarTokens;
        users[msg.sender].tokens += comprarTokens;
    }

    function getCantidadEther() public view returns (uint256){
        return address(this).balance;
    }

}