// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {StdInvariant, Test} from "forge-std/Test.sol";
import {Dex, SwappableToken} from "../../src/DEX.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Handler} from "./Handler.t.sol";

contract InvarientTest is StdInvariant, Test {
    Dex public dex;
    SwappableToken public token1;
    SwappableToken public token2;

    Handler public handler;
    address public attacker;

    function setUp() public {
        dex = new Dex();
        token1 = new SwappableToken(address(dex), "Token1", "TK1", 110);
        token2 = new SwappableToken(address(dex), "Token2", "TK2", 110);

        dex.setTokens(address(token1), address(token2));

        // token1.approve(address(dex), type(uint256).max);
        // token2.approve(address(dex), type(uint256).max);

        token1.transfer(address(dex), 100);
        token2.transfer(address(dex), 100);
        attacker = makeAddr("attacker");
        handler = new Handler(dex, attacker);

        bytes4[] memory selectors = new bytes4[](4);
        selectors[0] = Handler.swapToken1ToToken2.selector;
        selectors[1] = Handler.swapToken2ToToken1.selector;
        selectors[2] = Handler.swapFullToken1ToToken2.selector;
        selectors[3] = Handler.swapFullToken2ToToken1.selector;

        targetSelector(FuzzSelector({addr: address(handler), selectors: selectors}));

        targetContract(address(handler));
    }

    function invariant_PoolBalance() public view {
        uint256 dexBal1 = dex.balanceOf(address(token1), address(dex));
        uint256 dexBal2 = dex.balanceOf(address(token2), address(dex));
        assertGt(dexBal1, 0, "DEX drained of token1");
        assertGt(dexBal2, 0, "DEX drained of token2");
    }
}
