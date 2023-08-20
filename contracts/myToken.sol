// Functionality
// Only contract owner should be able to mint tokens
// Any user can transfer tokens
// Any user can burn tokens
// 0x66B0b1d2930059407DcC30F1A2305435fc37315E, 0x6827b8f6cc60497d9bf5210d602C0EcaFDF7C405
// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract MyToken {
    string public name = "Arzoo";
    string public symbol = "AC";
    uint256 public totalSupply = 10 * 10**uint256(10);
    address public owner = msg.sender;
    mapping(address => uint256) public balanceOf;

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    function transfer(address to, uint256 value) public returns (bool success) {
        require(to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        return true;
    }

    function burn(uint256 value) public returns (bool success) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        balanceOf[msg.sender] -= value;
        totalSupply -= value;
        return true;
    }

    function mint(address to, uint256 value) public onlyOwner {
        require(to != address(0), "Invalid address");

        balanceOf[to] += value;
        totalSupply += value;
    }
}
