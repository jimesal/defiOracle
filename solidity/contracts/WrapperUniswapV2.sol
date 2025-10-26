//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

import 'solidity/interfaces/IUniV2Pair.sol';

contract WrapperUniswapV2 {
  address constant UNISWAP_FACTORY = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;

  function quote(
    address _tokenIn,
    uint256 _amount,
    address _tokenOut
  ) external view returns (uint256 amountOut) {
    //Sort tokens
    (address _token0, address _token1) = _tokenIn < _tokenOut ? (_tokenIn, _tokenOut) : (_tokenOut, _tokenIn);

    //PairFor using the UniswapV2 factory
    address _pair = address(
      uint160(
        uint256(
          keccak256(
            abi.encodePacked(
              hex'ff',
              UNISWAP_FACTORY,
              keccak256(abi.encodePacked(_token0, _token1)),
              hex'96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f' // init code hash
            )
          )
        )
      )
    );

    //GetReserves with the previous pair
    (uint112 _reserve0, uint112 _reserve1, ) = IUniV2Pair(_pair).getReserves();

    //GetAmountOut
    uint256 _amountInWithFee = _amount * (997);
    uint256 _numerator = _amountInWithFee * (_reserve1);
    uint256 _denominator = _reserve0 * (1000) + (_amountInWithFee);
    return amountOut = _numerator / _denominator;
  }
}
