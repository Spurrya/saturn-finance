// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This is the smart contract for the borrowers- they won't be able to withdraw, only add to liquidity pool or close their position and get their deposit back.

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";


contract BorrowContract {
    IERC20 public token1;
    IERC20 public token2;
    IUniswapV2Router02 public uniswapRouter;
    mapping(address => uint256) public deposits;
    mapping(address => uint256) public borrowed;

    constructor(IERC20 _token1, IERC20 _token2, IUniswapV2Router02 _uniswapRouter) {
        token1 = _token1;
        token2 = _token2;
        uniswapRouter = _uniswapRouter;
    }

    function deposit(uint256 amount) public {
        // Transfer the tokens to this contract
        token1.transferFrom(msg.sender, address(this), amount);

        // Update the user's deposit amount
        deposits[msg.sender] += amount;
    }

    function borrow(uint256 amount) public {
        // Check if user has enough collateral
        require(deposits[msg.sender] * 3 >= amount, "Insufficient collateral");

        // Transfer the tokens to the borrower
        token1.transfer(msg.sender, amount / 2);
        token2.transfer(msg.sender, amount / 2);

        // Update the user's deposit amount
        deposits[msg.sender] -= amount;

        // Mock liquidity pool interaction. Replace with actual interaction.
        addToLiquidityPool(amount / 2, amount / 2);
    }

    // Mock function to represent adding to a liquidity pool
    function addToLiquidityPool(uint256 amountToken1, uint256 amountToken2) internal {
        // Approve the Uniswap Router to spend the tokens of this contract

        token1.approve(address(unshETHRouter), amountToken1);
        token2.approve(address(unshETHRouter), amountToken2);

        // Add the liquidity
        unshETHRouter.addLiquidity(
        address(token1),
        address(token2),
        amountToken1,
        amountToken2,
        0, // amountTokenMin: we set to 0 for simplicity, but can be set to a minimum to prevent price slippage
        0, // amountETHMin: same as above
        address(this), // to: tokens will be sent here after adding liquidity, usually set to the contract itself
        block.timestamp // deadline: timestamp to force the transaction to fail if not processed in time, usually set to a short time in the future
        );
    }


    function liquidate(address borrower) public {
        require(borrowed[borrower] > deposits[borrower] * 3, "Cannot liquidate");

        uint256 amountToLiquidate = borrowed[borrower] - deposits[borrower] * 3;

        // Transfer the tokens from the liquidator
        token1.transferFrom(msg.sender, address(this), amountToLiquidate / 2);
        token2.transferFrom(msg.sender, address(this), amountToLiquidate / 2);

        // Decrease the borrowed amount
        borrowed[borrower] -= amountToLiquidate;

        // Add the liquidated tokens to the liquidity pool
        addToLiquidityPool(amountToLiquidate / 2, amountToLiquidate / 2);
    }


}
