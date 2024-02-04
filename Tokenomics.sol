// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";



contract Tokenomics is ERC20 {

    address public owner;
    address public feeRecipient;
    uint public maxSupply= 100000000000000000;

    constructor() ERC20("Helix Token", "HLX") {
        _mint(msg.sender, maxSupply);
        owner=msg.sender;
        feeRecipient=msg.sender;
    }

    modifier onlyOwner(){
        require(owner==msg.sender, "only Owner has access");
        _;
    }

    function setFeeRecipient(address _feeRecipient) public onlyOwner {
        feeRecipient=_feeRecipient;

    }
event _settransfer(address feeRecipient, address owner, uint amount);
    function _Set_transfer(uint amount) public onlyOwner {
        require(amount>= 100, "amount has to be either 100 or more");
        _transfer(msg.sender, feeRecipient, amount);
      maxSupply-=amount;
        emit _settransfer(msg.sender, feeRecipient, amount);

    }

    function mint(uint amount, address to) public onlyOwner{
     
           _mint(to, amount);

    }

    function burn(uint amount) public onlyOwner {
        _burn(msg.sender, amount);
    }

    function trackTokens() public view returns(uint){
        return totalSupply();

    }


}
