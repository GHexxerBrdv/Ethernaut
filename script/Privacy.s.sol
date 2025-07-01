// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Privacy} from "../src/Privacy.sol";

contract PrivacyScript is Script {
    Privacy public code = Privacy(0xd09E4fa844b907960d190f6F14bdf76A19F6D67B);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        bytes16 key = bytes16(vm.load(address(code), bytes32(uint256(5))));
        code.unlock(key);
        vm.stopBroadcast();
    }
}
