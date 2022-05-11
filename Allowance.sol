// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable {
    using SafeMath for uint;

    event AllowanceChanged(address indexed _who, address indexed _fromWho, uint _oldAmount, uint _newAmount);
    event MoneyReceived(address indexed _from, uint _amount);

    mapping(address => uint) public allowance;

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed" );
        _;
    }

    function isOwner() internal view returns (bool) {
        return owner() == msg.sender;
    }

    function addAllowance(address _who, uint _amount) public onlyOwner  {
        allowance[_who] = _amount;
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
    }

    function reduceAllAllowance(address _who, uint _amount) internal {
        allowance[_who] = allowance[_who].sub(_amount);
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
    }
}


