//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

interface IOracle {
  function quote(
    address _tokenIn,
    uint256 _amount,
    address _tokenOut
  ) external view returns (uint256 amountOut);
}
