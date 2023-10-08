// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract MyToken {
    // Public variables to store token details
    string public tokenName = "hariyods";
    string public tokenAbbrv = "hira";
    uint256 public totalSupply;

    // Mapping to store balances of addresses
    mapping(address => uint256) public balances;

    // Address of the contract creator
    address public owner;

    // Modifier to restrict access to certain functions
    modifier onlyOwnerOrRecipient(address recipient) {
        require(msg.sender == owner || msg.sender == recipient, "Only owner or recipient can call this function");
        _;
    }

    // Constructor to initialize the total supply
    constructor(uint256 initialSupply) {
        totalSupply = initialSupply;
        balances[msg.sender] = initialSupply; // Initially, assign all tokens to the contract creator
        owner = msg.sender;
    }

    // Mint function to create new tokens
    function mint(address recipient, uint256 value) public onlyOwnerOrRecipient(recipient) {
        require(recipient != address(0), "Invalid recipient address");
        require(value > 0, "Value must be greater than 0");

        totalSupply += value;
        balances[recipient] += value;
    }

    // Burn function to destroy tokens
    function burn(uint256 value) public {
        require(balances[msg.sender] >= value, "Insufficient balance to burn");
        
        totalSupply -= value;
        balances[msg.sender] -= value;
    }

    // Get the contract owner
    function getOwner() public view returns (address) {
        return owner;
    }
}
