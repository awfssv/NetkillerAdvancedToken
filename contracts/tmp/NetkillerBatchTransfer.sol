pragma solidity ^0.4.24;

contract ERC20 {
    uint256 public totalSupply;
    uint public decimals;
    function balanceOf(address _address) constant public returns (uint256);
    function transfer(address _to, uint256 _value) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract NetkillerBatchTransfer {

    address public contractAddress;
    
    constructor(address _contractAddress) public {
        contractAddress = _contractAddress;
    }
    function getBalance(address _address) view public returns (uint256){
        ERC20 token = ERC20(contractAddress);
        return token.balanceOf(_address);
    }
    function batchTransfer(address[] _to, uint256 _value) public{
        
        ERC20 token = ERC20(contractAddress);
        uint256 value = _value * 10**uint256(token.decimals());
        
        for (uint i=0; i<_to.length; i++) {
            token.transfer(_to[i], value);
        }
    }
}
