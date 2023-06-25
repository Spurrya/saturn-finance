pragma solidity ^0.8.0;

 // This is the deposit contract for the lenders

contract DepositContract {
    mapping (address => uint256) private _balances;

    event Deposit(address indexed depositor, uint256 amount);
    event Withdrawal(address indexed depositor, uint256 amount);

    function deposit() public payable {
        _balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        _balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function getBalance() public view returns (uint256) {
        return _balances[msg.sender];
    }
}
