// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Dex, SwappableToken} from "../../src/DEX.sol";

contract Handler is Test {
    Dex public dex;
    SwappableToken public token1;
    SwappableToken public token2;

    address public attacker;

    constructor(Dex _dex, address _attacker) {
        dex = _dex;
        token1 = SwappableToken(dex.token1());
        token2 = SwappableToken(dex.token2());
        attacker = _attacker;
    }

    function swapToken1ToToken2(uint256 amount) public {
        vm.startPrank(attacker);
        uint256 attackerBalance = token1.balanceOf(attacker);
        amount = bound(amount, 1, attackerBalance);
        if (amount == 0) return;

        dex.approve(address(dex), amount);

        dex.swap(address(token1), address(token2), amount);

        vm.stopPrank();
    }

    function swapToken2ToToken1(uint256 amount) public {
        vm.startPrank(attacker);
        uint256 attackerBalance = token2.balanceOf(attacker);
        amount = bound(amount, 1, attackerBalance);
        if (amount == 0) return;

        dex.approve(address(dex), amount);

        dex.swap(address(token2), address(token1), amount);

        vm.stopPrank();
    }

    function swapFullToken1ToToken2() public {
        vm.startPrank(attacker);
        uint256 amount = token1.balanceOf(attacker);
        if (amount == 0) return;

        dex.approve(address(dex), amount);
        dex.swap(address(token1), address(token2), amount);
        vm.stopPrank();
    }

    // New action: Swap full balance of token2
    function swapFullToken2ToToken1() public {
        vm.startPrank(attacker);
        uint256 amount = token2.balanceOf(attacker);
        if (amount == 0) return;

        dex.approve(address(dex), amount);
        dex.swap(address(token2), address(token1), amount);
        vm.stopPrank();
    }
}
