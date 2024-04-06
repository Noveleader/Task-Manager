pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import { TaskManager } from "../src/TaskManager.sol";

contract TaskManagerTest is Test {
    TaskManager taskManager;

    function setUp() external {
        taskManager = new TaskManager();
    }

    function testAddItem() public {
        
        string memory taskDescription = "Buy groceries";
        taskManager.addItem(taskDescription);

        TaskManager.Task[] memory tasks = taskManager.getTasksForUser(address(this));

        assertEq(tasks.length, 1);
        assertEq(tasks[0].description, taskDescription);
        assertEq(tasks[0].completed, false);
    }

    function testDeleteItem() public {
        string memory taskDescription = "Buy groceries";
        taskManager.addItem(taskDescription);

        taskManager.deleteItem(0);
        assertEq(taskManager.getTaskCount(address(this)), 0);
    }

    function testMarkTaskCompleted() public {
        string memory taskDescription = "Buy groceries";
        taskManager.addItem(taskDescription);

        taskManager.markTaskCompleted(0);
        assertEq(taskManager.getTasksForUser(address(this))[0].completed, true);
    }
}

