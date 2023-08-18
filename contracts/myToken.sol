// Functionality
// Only contract owner should be able to mint tokens
// Any user can transfer tokens
// Any user can burn tokens
// 0x66B0b1d2930059407DcC30F1A2305435fc37315E, 0x6827b8f6cc60497d9bf5210d602C0EcaFDF7C405
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public name = "MyToken";
    string public symbol = "MT";
    uint256 public totalSupply= 10 * 10**uint256(10);
    address public owner = msg.sender;
    mapping(address => uint256) public balanceOf;
    
    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        return true;
    }

    function burn(uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
        return true;
    }

    function mint(address _to, uint256 _value) public {

        balanceOf[_to] += _value;
        totalSupply += _value;
        if(_to != owner){
            revert("You are not the owner of the contract");
        } 
    }
}
