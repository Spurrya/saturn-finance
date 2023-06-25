// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./IERC20.sol";

contract ERC20Adapter {
    IERC20 public token;

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
        return token.transferFrom(sender, recipient, amount);
    }
}
