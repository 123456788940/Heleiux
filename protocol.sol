// SPDX-License-Identifier: MIT

pragma solidity ^0.8;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract HeleiuxProtocol is ERC20 {
    constructor() ERC20("Heliux Token", "HT"){
      _mint(msg.sender, 100000000000000*10*18);
      owner = msg.sender;
    }
         uint rewardPerBlock = 10;
        mapping(address=>uint) public stakingBalance;
        mapping(address=>uint) public lastClaimedBlock;
         address public owner;
        modifier onlyOwner() {
            require(owner == msg.sender);
            _;
        }

        function stake(uint amount) public onlyOwner {
            require(amount >= 100, "amount has to be at least 100");
            require(balanceOf(msg.sender) >= amount, "not much tokens to stake");
            transfer(address(this), amount);
            stakingBalance[msg.sender] += amount;
            lastClaimedBlock[msg.sender] = block.number;
        }

        function unstake(uint amount) public onlyOwner {
            require(amount> 0, "amount has to be greater than 0");
            require(stakingBalance[msg.sender] >= amount, "Not enough staked tokens");
            transfer(msg.sender, amount);
            stakingBalance[msg.sender] -= amount;
            lastClaimedBlock[msg.sender] = block.number;
        }

        function claimReward() public {
            uint blockSinceLastClaim = block.number - lastClaimedBlock[msg.sender];
            require(blockSinceLastClaim > 0, "no block escaped since last claim");
            uint reward =stakingBalance[msg.sender] * rewardPerBlock * blockSinceLastClaim;
            require(reward>0, "no reward claimed");
            _mint(msg.sender, reward);
            lastClaimedBlock[msg.sender] = block.number;
        }
}
