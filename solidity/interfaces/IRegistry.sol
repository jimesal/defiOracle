//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

interface IRegistry {
  function find_pool_for_coins(
    address _from,
    address _to,
    uint256 i
  ) external view returns (address pool);

  function get_coin_indices(
    address pool,
    address _from,
    address _to
  )
    external
    view
    returns (
      int128,
      int128,
      bool
    );

  function get_dy(
    int128 i,
    int128 j,
    uint256 _dx
  ) external view returns (uint256 amountOut);
}
