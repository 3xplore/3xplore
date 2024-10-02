// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UserProfile.sol";

contract Rewards {

    UserProfile userProfile;

    event RewardClaimed(address indexed user, uint256 xpAmount);

    constructor(address _userProfileAddress) {
        userProfile = UserProfile(_userProfileAddress);
    }

    // Claim a reward by spending XP
    function claimReward(uint256 xpAmount) public {
        require(userProfile.getXP() >= xpAmount, "Not enough XP");
        userProfile.redeemRewards(xpAmount);
        emit RewardClaimed(msg.sender, xpAmount);
        
        // Logic for additional rewards (e.g., NFTs, tokens, etc.) can be added here.
    }

    // Award an achievement to the caller
    function awardAchievement(string memory achievementId) public {
        userProfile.unlockAchievement(achievementId);
    }

    // Check if the caller has a specific achievement
    function checkAchievement(string memory achievementId) public view returns (bool) {
        return userProfile.hasAchievement(achievementId);
    }
}
