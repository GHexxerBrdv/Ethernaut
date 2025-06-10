// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {Instance} from "../src/Hello.sol";

contract Hello is Script {
    Instance public code = Instance(0xc774be3AcACb976A7FbCf82214fD9094d2848582);

    function run() external {
        string memory password = code.password();
        console.log("password: ", password);
        vm.startBroadcast(vm.envUint("PRIV"));
        code.authenticate(password);
        vm.stopBroadcast();
    }
}
