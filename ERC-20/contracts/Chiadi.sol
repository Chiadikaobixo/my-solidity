// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract Chiadi is IERC20 {
    using SafeMath for uint256;
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    // total number of `Chiadi XO` token
    uint256 private _totalSupply;
    address private _owner = 0x2Ca3138492c364AA09e6525720f34dc645EBFBAA;
    // returns true if it is an approved owner
    mapping(address => bool) private _approvedOwners;
    // balance of addresses
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    event Create(address, uint256, string, uint256);
    event Change(address, uint256, address);
    event Mint(address, uint256, uint256);
    event Burn(address, uint256, uint256);

    constructor() {
        _name = "Chiadi XO";
        _symbol = "CXO";
        _decimals = 18;
        _totalSupply = 1000000000 * (10**_decimals);
        // _owner gets the whole token.
        _balances[_owner] = _totalSupply;
        // marks the owner as approved 
        _approvedOwners[_owner] = true;
        emit Create(_owner, block.timestamp, _name, _totalSupply);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns(string memory) {
       return _symbol;
    }

    function decimals() public view returns(uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns(uint256) {
        return _totalSupply;
    }
     
    function balanceOf(address account)public view override returns (uint256){
        return _balances[account];
    }

    /**
     * @dev Moves the `amount` of tokens from the caller's account (which must be an `approvedOwners`)
     * to `to`. It returns a boolean value indicating whether the operation succeeded.
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) public override returns(bool) {
        require(msg.sender != address(0), "!Address");             
        require(to != address(0), "Not a valid receivers address");                                 
        require(approvedOwners(msg.sender), "Account does not exist");              
        require(amount > 0, "Amountshould be greaterthan 0");                                     
        require(_balances[msg.sender] >= amount, "address of wallet less than amount");
        _balances[to] = _balances[to].add(amount);       
        _balances[msg.sender] = _balances[msg.sender].sub(amount); 
        _approvedOwners[to] = true;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    /**
    * @dev Returns the remaining number of tokens that `spender` will be
    * allowed to spend on behalf of `owner` through {transferFrom}. This is
    * zero by default.
    *
    * This value changes when {approve} or {transferFrom} are called.
    * @param owner and spender is an address with a cxo token
    */
    function allowance(address owner, address spender) public view override returns(uint256) {
        require(msg.sender != address(0), "!Address");
        require(owner != address(0), "!Owner");
        require(spender != address(0), "!Spender");
        require(approvedOwners(owner), "!Owner");
        require(approvedOwners(spender), "!Spender");
        require(anyOf(owner, spender), "!Owner && !Spender)");
        uint256 _allowance = _allowances[owner][spender];
        return _allowance;
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner = msg.sender` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public override returns(bool) {
        require(msg.sender != address(0), "!Address");
        require(spender != address(0), "!Spender");
        require(approvedOwners(msg.sender), "!Account Exists");
        require(msg.sender != spender, "Caller == Spender");
        require(_balances[msg.sender] >= amount, "Balance < Amount");
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns(bool) {
        require(spender != address(0), "!Spender");
        require(msg.sender != address(0), "!Address");
        require(approvedOwners(msg.sender), "!Account Exists");
        require(msg.sender != spender, "Caller == Spender");
        require(_balances[msg.sender] >= addedValue, "Balance < AddedValue");
        address owner = msg.sender;
        approve(spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        require(spender != address(0), "!Spender");
        require(spender != address(0), "!Spender");
        uint256 currentAllowance = allowance(msg.sender, spender);
        require(currentAllowance >= subtractedValue, "you cannot decreased allowance below zero");
        unchecked {
            approve(spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
    * @dev Moves `amount` tokens from `from` to `to` using the
    * allowance mechanism. `amount` is then deducted from the caller's
    * allowance.
    *
    * Returns a boolean value indicating whether the operation succeeded.
    *
    * Emits a {Transfer} event.
    */
    function transferFrom(address from, address to, uint256 amount) public override returns(bool) {
        require(msg.sender != address(0), "!Address");
        require(from != address(0), "!From");
        require(to != address(0), "!To");
        require(approvedOwners(from), "From !Exists");
        require(approvedOwners(to), "To !Exists");
        require(_allowances[from][msg.sender] >= amount, "Balance < Amount");
        _balances[from] = _balances[from].sub(amount);
        _balances[to] = _balances[to].add(amount);
        _allowances[from][msg.sender] = _allowances[from][msg.sender].sub(amount);
        emit Transfer(from, to, amount);
        return true;
    }
 
    /*
    * @dev: {mint()} adds more tokens to the `_totalSupply`.
    */
    function mint(uint256 amount) public {
        require(msg.sender == _owner, "!Owner");
        uint256 _supply = amount * (10 ** _decimals);
        _totalSupply = _totalSupply.add(_supply);
        // increase balance
        _balances[_owner] += _supply;
        emit Mint(msg.sender, block.timestamp, _supply);
    }
    
    /*
    * @dev: burn() removes from the token
    */
    function burn(uint256 amount) public {
        require(msg.sender == _owner, "!Owner");
        uint256 _supply = amount * (10 ** _decimals);
        _totalSupply = _totalSupply.sub(_supply);
        // decrease balance
        _balances[_owner] -= _supply;
        emit Burn(msg.sender, block.timestamp, _supply);
    }

    /*
    * @dev: {changeOwner()} changes owner of token
    */
    function changeOwner(address new_owner) public {
        require(msg.sender == _owner, "!Owner");
        require(new_owner != _owner, "New Owner == Old owner");
        _owner = new_owner;
        emit Change(msg.sender, block.timestamp, new_owner);
    }
    
    /**
    * @dev checks if any of the params is equal to the callers address
    */
    function anyOf(address __owner, address __spender) private view returns(bool) {
        return((msg.sender == __owner) || msg.sender == __spender);
    }
    
    /**
    * @dev approvedOwners verifies if the address owns a CXO token
    */
    function approvedOwners(address accountAddress) private view returns(bool) {
        return _approvedOwners[accountAddress];
    }
}
