// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

error TaskIsEmpty();
error InvalidTaskIndex();

contract TaskManager {
    struct Task {
        string description;
        bool completed;
    }

    mapping(address => Task[]) public taskMapping;

    event TaskAdded(address indexed user, string description);
    event TaskDeleted(address indexed user, uint256 taskIndex);
    event TaskCompleted(address indexed user, uint256 taskIndex);

    modifier onlyValidDescription(string memory description) {
        if (bytes(description).length == 0) revert TaskIsEmpty();
        // require(bytes(description).length > 0, "TaskIsEmpty");
        _;
    }

    function addItem(
        string memory taskDescription
    ) public onlyValidDescription(taskDescription) {
        taskMapping[msg.sender].push(Task(taskDescription, false));
        emit TaskAdded(msg.sender, taskDescription);
    }

    function deleteItem(uint256 taskIndex) public {
        if (taskIndex > taskMapping[msg.sender].length - 1) revert InvalidTaskIndex();
        // require(taskIndex < taskMapping[msg.sender].length, "InvalidTaskIndex");
        // delete taskMapping[msg.sender][taskIndex];

         // Shift elements one step back starting from the deleted index
        for (uint256 i = taskIndex; i < taskMapping[msg.sender].length - 1; i++) {
            taskMapping[msg.sender][i] = taskMapping[msg.sender][i + 1];
        }

        // Remove the last element which is now a duplicate and decrease the array length
        taskMapping[msg.sender].pop();
        emit TaskDeleted(msg.sender, taskIndex);
    }

    function markTaskCompleted(uint256 taskIndex) public {
        if (taskIndex > taskMapping[msg.sender].length - 1) revert InvalidTaskIndex();
        taskMapping[msg.sender][taskIndex].completed = true;
        emit TaskCompleted(msg.sender, taskIndex);
    }

    function getTasksForUser(address userAddress) public view returns(Task[] memory) {
        return taskMapping[userAddress];
    }

    function getTaskCount(address userAddress) public view returns(uint256) {
        return taskMapping[userAddress].length;
    }

}
