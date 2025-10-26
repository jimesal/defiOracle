//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

import '@uniswap/v3-periphery/contracts/libraries/PoolAddress.sol';
import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol';
import 'solidity/interfaces/IQuoter.sol';

contract WrapperUniswapV3 {
  address immutable quoter;

  constructor(address _quoter) {
    quoter = _quoter;
  }

  function quote(
    address _tokenIn,
    uint256 _amount,
    address _tokenOut
  ) external view returns (uint256 amountOut) {
    (address _token0, address _token1) = _tokenIn < _tokenOut ? (_tokenIn, _tokenOut) : (_tokenOut, _tokenIn);
    IUniswapV3Pool _pool = IUniswapV3Pool(
      PoolAddress.computeAddress(0x1F98431c8aD98523631AE4a59f267346ea31F984, PoolAddress.getPoolKey(_token0, _token1, 3))
    );
    bytes memory _path = abi.encodePacked(_pool);
    uint256 _amountOut = IQuoter(quoter).quoteExactInput(_path, _amount);
    return _amountOut;
  }
}
