pragma solidity ^0.4.18;
//import "./ERC20Interface.sol";

contract DHFixedToken {
  // 1. Declare the metadata for the coin
  //    All of thse variables declared public constant - so available as functions
  string public constant name = "DH Fixed Token";
  string public constant symbol = "DHF";

  // Token values are passed as integers so decimals is the number of decimals from righ
  // E.g., decimals = 2, value=100 interpretted as 1.00
  // E.g., decimals = 1, value=100 interpretted as 10.0
  uint8  public constant decimals = 0;

  mapping(address => mapping (address => uint256)) allowances;

  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

  // 6. Declare the event
  event Transfer(address _from, address _to, uint256 _value);

  // 2. Maintain the total supply
  uint256 public totalSupply;

  // 4. Maintain the balance in a mapping
  mapping(address => uint256)  balances;

  // 3. Constructor sets the initial supply as total available
  function DHFixedToken(uint256 initSupply) {
    // constructor

    // Set the initial supply
    totalSupply = initSupply;

    // Set the sender as the owner of all the initial set of tokens
    // Declare the balances mapping
    balances[msg.sender] = totalSupply;
  }

  // 5. transfer
  function transfer(address _to, uint256 _value) returns (bool success) {
    // Return false if specified value is less than the balance available
    if (_value > 0 && balances[msg.sender] < _value) {
      return false;
    }

    // Reduce the balance by _value
    balances[msg.sender] -= _value;

    // Increase the balance of the receiever that is account with address _to
    balances[_to] += _value;

    // Declare & Emit the transfer event
    Transfer(msg.sender, _to, _value);

    return true;
  }

  // 7. balanceOf
  // Anyone can call this constant function to check the balance of tokens for an address
  function balanceOf(address _someone) constant returns (uint256 balance){
    return balances[_someone];
  }

  // How many tokens can spender spend from owner's account
  function allowance(address _owner, address _spender) constant returns (uint remaining){
    //1. Declare a mapping to manage allowances
    //2. Return the allowance for _spender approved by _owner
    return allowances[_owner][_spender];
  }

  // Approval - sets the allowance
  function approve(address _spender, uint256 _value) returns (bool success) {
    if(_value <= 0)
      return false;

    // 3. Simply add/change the amount in allowances
    allowances[msg.sender][_spender] = _value;

    // 4. Declare the Approval event and emit it
    Approval(msg.sender, _spender, _value);

    return true;
  }

  // Transfer from
  // B transfer _value from A's account to C' account
  function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
    // Multiple if statements to make it easy to understand
    // a) b) c) below may be combined with && in one statememnt

    // a) Specified _value must be > 0
    if(_value <= 0)
      return false;

    // b) Check if _spender allowed to spend the specified _value from _from account
    // Spender's address = msg.sender
    if(allowances[_from][msg.sender] < _value)
      return false;

    // c) Check if the _from has enough tokens
    if(balances[_from] < _value)
      return false;

    // Reduce the balance _from
    balances[_from] -= _value;
    // Increase the balance _to
    balances[_to] += _value;

    // Reduce the allowance for spender
    allowances[_from][msg.sender] -= _value;

    // Emit a transfer event
    Transfer(_from, _to, _value);

    return true;
  }
}
