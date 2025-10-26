//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

import '@chainlink/contracts/src/v0.8/interfaces/FeedRegistryInterface.sol';

import 'hardhat/console.sol';

contract WrapperChainlink {
  FeedRegistryInterface internal registry;

  constructor(address _registry) {
    registry = FeedRegistryInterface(_registry);
  }

  function quote(
    address _tokenIn,
    uint256 _amount,
    address _tokenOut
  ) external view returns (uint256 amountOut) {
    (, int256 price, , , ) = registry.latestRoundData(_tokenIn, _tokenOut);
    console.log('aqui');
    return _amount * uint256(price);
  }
}
