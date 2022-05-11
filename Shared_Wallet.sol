// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Allowance.sol";

contract SharedWallet is Allowance {
    
    function withdraw(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance, "There are not enough funds stored in the smart contract");
        if(!isOwner()){
            reduceAllAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
    
}