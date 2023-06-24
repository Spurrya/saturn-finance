// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC20Adapter.sol";

contract TokenSwap {
    ERC20Adapter public token1;
    ERC20Adapter public token2;

    constructor(address _token1Address, address _token2Address) {
        token1 = ERC20Adapter(_token1Address);
        token2 = ERC20Adapter(_token2Address);
    }

    function swap(address user1, address user2, uint256 amount1, uint256 amount2) external {
        require(token1.transferFrom(user1, user2, amount1), "Token1 transfer failed");
        require(token2.transferFrom(user2, user1, amount2), "Token2 transfer failed");
    }
}
