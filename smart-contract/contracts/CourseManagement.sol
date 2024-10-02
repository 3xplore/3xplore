// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UserProfile.sol";

contract CourseManagement {

    struct Module {
        string title;
        string content; // Could be a URL or hash pointing to external storage like IPFS
        bool isCompleted; // Whether the user has completed this module
    }

    struct Course {
        string name;
        uint256 totalModules;
        bool isActive;
        bool isQuizRequired;
        mapping(uint256 => Module) modules; // Map module number to Module struct
        mapping(address => bool) enrolledUsers; // Keep track of who enrolled
        mapping(address => uint256) userProgress; // Track user progress for each course
    }

    mapping(string => Course) public courses; // Store courses with courseId as key
    UserProfile userProfile; // Link to UserProfile contract

    event CourseCreated(string courseId, string name);
    event ModuleCreated(string courseId, uint256 moduleNumber, string title);
    event ModuleCompleted(address indexed user, string courseId, uint256 moduleNumber);
    event QuizCompleted(address indexed user, string courseId, uint256 score);
    
    constructor(address _userProfileAddress) {
        userProfile = UserProfile(_userProfileAddress);
    }

    modifier onlyEnrolled(string memory courseId) {
        require(courses[courseId].enrolledUsers[msg.sender], "User not enrolled in course");
        _;
    }

    modifier courseExists(string memory courseId) {
        require(courses[courseId].isActive, "Course does not exist or is not active");
        _;
    }

    // Create a new course
    function createCourse(string memory courseId, string memory name, bool isQuizRequired) public {
        Course storage course = courses[courseId];
        course.name = name;
        course.isActive = true;
        course.isQuizRequired = isQuizRequired;
        emit CourseCreated(courseId, name);
    }

    // Add a new module to a course
    function addModule(string memory courseId, uint256 moduleNumber, string memory title, string memory content) public courseExists(courseId) {
        Course storage course = courses[courseId];
        require(moduleNumber > 0 && moduleNumber == course.totalModules + 1, "Invalid module number");
        
        course.modules[moduleNumber] = Module({
            title: title,
            content: content,
            isCompleted: false
        });
        
        course.totalModules += 1; // Increment the total module count
        emit ModuleCreated(courseId, moduleNumber, title);
    }

    // Enroll a user in a course
    function enrollInCourse(string memory courseId) public courseExists(courseId) {
        courses[courseId].enrolledUsers[msg.sender] = true;
    }

    // Get module content for a specific course and module number
    function getModuleContent(string memory courseId, uint256 moduleNumber) public view onlyEnrolled(courseId) courseExists(courseId) returns (string memory title, string memory content) {
        require(moduleNumber > 0 && moduleNumber <= courses[courseId].totalModules, "Module does not exist");
        Module memory module = courses[courseId].modules[moduleNumber];
        return (module.title, module.content);
    }

    // Complete a module in a course
    function completeModule(string memory courseId, uint256 moduleNumber) public onlyEnrolled(courseId) courseExists(courseId) {
        require(moduleNumber > 0 && moduleNumber <= courses[courseId].totalModules, "Invalid module number");

        // Mark the module as completed
        courses[courseId].modules[moduleNumber].isCompleted = true;

        // Track user progress for the course
        courses[courseId].userProgress[msg.sender] = moduleNumber;
        userProfile.trackCourseProgress(courseId, moduleNumber);

        emit ModuleCompleted(msg.sender, courseId, moduleNumber);
        
        // If the user completed the final module, award XP and achievement
        if (moduleNumber == courses[courseId].totalModules) {
            userProfile.unlockAchievement(courseId);
            userProfile.increaseXP(100); // Reward XP for completing the course
        }
    }

    // Complete a quiz for a course
    function completeQuiz(string memory courseId, uint256 score) public onlyEnrolled(courseId) courseExists(courseId) {
        require(courses[courseId].isQuizRequired, "No quiz for this course");

        // Award XP if score is above a threshold (e.g., 70%)
        emit QuizCompleted(msg.sender, courseId, score);
        if (score > 70) {
            userProfile.increaseXP(50); // Reward XP for passing the quiz
        }
    }

    // Deactivate a course (for admin use)
    function deactivateCourse(string memory courseId) public {
        courses[courseId].isActive = false;
    }

    // Get course progress for a user
    function getUserProgress(string memory courseId, address user) public view returns (uint256) {
        return courses[courseId].userProgress[user];
    }

    // Check if a user is enrolled in a course
    function isEnrolled(string memory courseId) public view returns (bool) {
        return courses[courseId].enrolledUsers[msg.sender];
    }
}
