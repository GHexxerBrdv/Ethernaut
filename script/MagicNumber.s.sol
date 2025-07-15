// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {MagicNum} from "../src/MagicNumber.sol";

contract MagicNumScript is Script {
    MagicNum public code = MagicNum(0x8DF069E54346db56B7F4003d1523Ac944554d476);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));

        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address solver;

        assembly {
            solver := create(0, add(bytecode, 0x20), 0x13)
        }

        require(solver != address(0), "Deployment failed");

        // Set the solver in the MagicNum contract
        code.setSolver(solver);

        vm.stopBroadcast();
    }
}
