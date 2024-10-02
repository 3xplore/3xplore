// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserProfile {

    struct Profile {
        string username;
        string email; // Optional
        string profilePicture; // Optional - IPFS hash or URL
        string bio; // Optional
        uint256 xp; // Experience points to track user engagement
        uint256 rewards; // Rewards points for redeeming rewards
        bool exists; // To ensure the profile exists
        mapping(string => bool) achievements; // Map of achievement IDs to check if unlocked
        mapping(string => uint256) courseProgress; // Track progress for each course by ID
    }

    mapping(address => Profile) public profiles;

    event ProfileCreated(address indexed user, string username);
    event ProfileUpdated(address indexed user, string profilePicture, string bio);
    event XPIncreased(address indexed user, uint256 xp);
    event AchievementUnlocked(address indexed user, string achievementId);

    modifier profileExists() {
        require(profiles[msg.sender].exists, "Profile does not exist");
        _;
    }

    // Create a profile with username and optional email
    function createProfile(string memory _username, string memory _email) public {
        require(!profiles[msg.sender].exists, "Profile already exists");
        
        // Initialize the profile data without mappings
        Profile storage newProfile = profiles[msg.sender];
        newProfile.username = _username;
        newProfile.email = _email;
        newProfile.profilePicture = "";
        newProfile.bio = "";
        newProfile.xp = 0;
        newProfile.rewards = 0;
        newProfile.exists = true;

        emit ProfileCreated(msg.sender, _username);
    }

    // Update optional profile settings
    function updateProfile(string memory _profilePicture, string memory _bio) public profileExists {
        profiles[msg.sender].profilePicture = _profilePicture;
        profiles[msg.sender].bio = _bio;
        emit ProfileUpdated(msg.sender, _profilePicture, _bio);
    }

    // Track course progress for users
    function trackCourseProgress(string memory courseId, uint256 progress) public profileExists {
        profiles[msg.sender].courseProgress[courseId] = progress;
    }

    // Retrieve course progress by course ID
    function getCourseProgress(string memory courseId) public view profileExists returns (uint256) {
        return profiles[msg.sender].courseProgress[courseId];
    }

    // Increase XP after completing courses or quizzes
    function increaseXP(uint256 xp) public profileExists {
        profiles[msg.sender].xp += xp;
        emit XPIncreased(msg.sender, xp);
    }

    // Check XP balance
    function getXP() public view profileExists returns (uint256) {
        return profiles[msg.sender].xp;
    }

    // Unlock achievements on the blockchain
    function unlockAchievement(string memory achievementId) public profileExists {
        profiles[msg.sender].achievements[achievementId] = true;
        emit AchievementUnlocked(msg.sender, achievementId);
    }

    // Check if an achievement is unlocked
    function hasAchievement(string memory achievementId) public view profileExists returns (bool) {
        return profiles[msg.sender].achievements[achievementId];
    }

    // Redeem rewards using XP
    function redeemRewards(uint256 xpAmount) public profileExists {
        require(profiles[msg.sender].xp >= xpAmount, "Not enough XP");
        profiles[msg.sender].xp -= xpAmount;
        profiles[msg.sender].rewards += xpAmount; // Simulating rewards with XP
    }

    // Check total rewards balance
    function getRewards() public view profileExists returns (uint256) {
        return profiles[msg.sender].rewards;
    }

}
