pragma solidity ^0.4.0;

contract BubbleCoin{

    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) approved; // approved[owner][spender]
    uint supply;

    //MARK: - ERC20 functions
    function totalSupply() constant returns (uint totalSupply) {
        // returns the totoal circulation of the token
        return supply;
    }

    function balanceOf(address _owner) constant returns (uint balance) {
        // returens the token blance of the given address
        return balances[_owner];
    }

    function transfer(address _to, uint _value) returns (bool success) {
        // transfers token from one address to another
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            return true;
        } else {
            // failed
            return false;
        }
    }

    function approve(address _spender, uint _value) returns (bool success) {
        // approves an address to spend your money
        if (balances[msg.sender] >= _value) {
            approved[msg.sender][_spender] = _value;
            return true;
        } else {
            return false;
        }
    }

    function allowance(address _owner, address _spender) constant returns (uint remaining) {
        // returns token allowed for a spender address of given owner address
        return approved[_owner][_spender];
    }

    function transferFrom(address _from, address _to, uint _value) returns (bool success) {
        // transfers token from an owner address to a spender address (call by spender)
        if (balances[_from] >= _value && approved[_from][msg.sender] >= _value && _value > 0) {
            balances[_from] -= _value;
            approved[_from][msg.sender] -= _value;
            balances[_to] += _value;
            return true;
        } else {
            return false;
        }
    }

    //MARK: - My own functions
    function mint(uint numberOfCoins) {
        // mints token to the caller address
        balances[msg.sender] += numberOfCoins;
        supply += numberOfCoins;
    }

    function getMyBalance() returns (uint) {
        // gets token balance of the caller address
        return balances[msg.sender];
    }

    // event Transfer(address indexed _from, address indexed _to, uint _value);
    // event Approval(address indexed _owner, address indexed _spender, uint _value);

}
