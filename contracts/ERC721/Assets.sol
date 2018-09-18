pragma solidity ^0.4.25;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that revert on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, reverts on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    require(c / a == b);

    return c;
  }

  /**
  * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b > 0); // Solidity only automatically asserts when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;
  }

  /**
  * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b <= a);
    uint256 c = a - b;

    return c;
  }

  /**
  * @dev Adds two numbers, reverts on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a);

    return c;
  }

  /**
  * @dev Divides two numbers and returns the remainder (unsigned integer modulo),
  * reverts when dividing by zero.
  */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b != 0);
    return a % b;
  }
}        

contract Ownable {
    
    address public owner;
    
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

}

contract NFT is Ownable {
    using SafeMath for uint256;
    
    string public name;
    string public symbol;
    uint public decimals;
    uint256 public totalSupply;
    
    mapping(address => mapping(string => uint256)) internal balances;
    mapping(string => address) internal tokens;
    
    event Transfer(address indexed _from, address indexed _to, string indexed _tokenId);
    event Burn(address indexed from, string _tokenId);
    
    constructor(
        string tokenName,
        string tokenSymbol,
        uint decimalUnits
    ) public {
        owner = msg.sender;
        name = tokenName;
        symbol = tokenSymbol; 
        decimals = decimalUnits;
        totalSupply = 0; 
        
    }
    
    function add(address _owner, string _tokenId) onlyOwner returns(bool status){
        balances[_owner][_tokenId] = 100 * 10 ** uint256(decimals);
        tokens[_tokenId] = _owner;
        totalSupply = totalSupply.add(1);
        return true;
    }
    
    function balanceOf(address _owner, string _tokenId) constant returns(uint balance){ 
        return balances[_owner][_tokenId];
    }

    function ownerOf(string _tokenId) constant returns (address owner) {
        return tokens[_tokenId];
    }
    
    function transfer(address _to, string _tokenId){
        
        address _from = msg.sender;
        uint256 amount = balances[_from][_tokenId];
        transfer(_to, amount, _tokenId);
    }
    function transfer(address _to, uint256 _value, string _tokenId){
        require(msg.sender == ownerOf(_tokenId));
        require(msg.sender != _to);
        require(_to != address(0));
        
        address _from = msg.sender;
        uint256 amount = balances[_from][_tokenId];
        require(amount >= _value);
        
        balances[_from][_tokenId] = balances[_from][_tokenId].sub(_value);
        balances[_to][_tokenId] = balances[_to][_tokenId].add(_value);
        tokens[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }
    
    function burn(address _owner, string _tokenId) onlyOwner public returns (bool success) {
        require(balances[_owner][_tokenId] > 0 && balances[_owner][_tokenId] == 100 * 10 ** uint256(decimals));

        balances[_owner][_tokenId] = 0;
        tokens[_tokenId] = address(0);

        totalSupply = totalSupply.sub(1);
        emit Burn(msg.sender, _tokenId);
        return true;
    }
    
}
