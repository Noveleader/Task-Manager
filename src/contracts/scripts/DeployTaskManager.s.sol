// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {TaskManager} from "../src/TaskManager.sol";

contract DeployTaskManager is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        new TaskManager();
        vm.stopBroadcast();
    }
}
