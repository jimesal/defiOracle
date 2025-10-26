//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

import '@sushiswap/core/contracts/uniswapv2/interfaces/IUniswapV2Pair.sol';
import '@sushiswap/core/contracts/uniswapv2/interfaces/IUniswapV2Factory.sol';

contract WrapperSushiswap {
  IUniswapV2Factory public constant SUSHIFACTORY = IUniswapV2Factory(0xC0AEe478e3658e2610c5F7A4A2E1777cE9e4f2Ac);

  function quote(
    address _tokenIn,
    uint256 _amount,
    address _tokenOut
  ) external view returns (uint256 amountOut) {
    //Sort tokens
    (address _token0, address _token1) = _tokenIn < _tokenOut ? (_tokenIn, _tokenOut) : (_tokenOut, _tokenIn);

    IUniswapV2Pair pair = IUniswapV2Pair(SUSHIFACTORY.getPair(_token0, _token1));
    //GetReserves with the previous pair
    (uint112 _reserve0, uint112 _reserve1, ) = IUniswapV2Pair(pair).getReserves();

    //GetAmountOut
    uint256 _amountInWithFee = _amount * (997);
    uint256 _numerator = _amountInWithFee * (_reserve1);
    uint256 _denominator = _reserve0 * (1000) + (_amountInWithFee);
    return amountOut = _numerator / _denominator;
  }
}
