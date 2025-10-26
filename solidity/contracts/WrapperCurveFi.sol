//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

import 'solidity/interfaces/IRegistry.sol';
import 'solidity/interfaces/ICryptoPool.sol';

contract WrapperCurveFi {
  address immutable registry;

  constructor(address _registry) {
    registry = _registry;
  }

  function quote(
    address _tokenIn,
    uint256 _amount,
    address _tokenOut
  ) external view returns (uint256 amountOut) {
    address poolCoins = IRegistry(registry).find_pool_for_coins(_tokenIn, _tokenOut, 0);
    (int128 fromIndex, int128 toIndex, ) = IRegistry(registry).get_coin_indices(poolCoins, _tokenIn, _tokenOut);

    return ICryptoPool(poolCoins).get_dy(fromIndex, toIndex, _amount);
  }
}
