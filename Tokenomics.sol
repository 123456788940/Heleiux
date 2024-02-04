// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";



contract Tokenomics is ERC20 {
    address private charityWallet;
    address public owner;
    address public feeRecipient;
    uint public maxSupply= 100000000000000000;
    address private companyAccount;

    constructor(address _charityWallet, address _companyAccount) ERC20("Helix Token", "HLX") {
        _mint(msg.sender, maxSupply);
        owner=msg.sender;
        feeRecipient=msg.sender;
        charityWallet=_charityWallet;
        companyAccount=_companyAccount;
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
           maxSupply+=amount;

    }

    function burn(address distributeTo, uint amount) public onlyOwner {
        
        _burn(address(this), amount);
        transferFrom(address(this), distributeTo,  amount*100/5);
           transferFrom(address(this), charityWallet, amount*100/10);
             transferFrom(address(this), companyAccount, amount*100/75);
           maxSupply-=amount;
         
       
    }

    function trackTokens() public view returns(uint){
        return totalSupply();

    }


}
