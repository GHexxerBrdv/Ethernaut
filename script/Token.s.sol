// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenScript is Script {
    Token public code = Token(0x3dc03192dbe68228Bb8d22545697feA8982615D0);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        code.transfer(address(0), 21);
        vm.stopBroadcast();
    }
}
