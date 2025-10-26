//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

interface IQuoter {
  function quoteExactInput(bytes memory path, uint256 amountIn) external view returns (uint256 amountOut);
}
