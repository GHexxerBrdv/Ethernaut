// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {Fallout} from "../src/Fallout.sol";

contract CounterScript is Script {
    Fallout public code = Fallout(0x399527fd5672d02bCcc6Af2257ed6ead04ce3c6d);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        code.Fal1out{value: 1}();
        code.collectAllocations();
        vm.stopBroadcast();
    }
}
