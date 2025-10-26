//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

import 'solidity/interfaces/IOracle.sol';
import 'solidity/interfaces/IEvents.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import '@openzeppelin/contracts/utils/structs/EnumerableSet.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

import 'hardhat/console.sol';

contract Oracle is Ownable, IEvents {
  mapping(address => mapping(address => address)) public wrappers;
  address public defaultWrapper;

  using EnumerableSet for EnumerableSet.AddressSet;
  EnumerableSet.AddressSet private allWrappers;

  using SafeMath for uint256;

  constructor(address _defaultWrapper) {
    defaultWrapper = _defaultWrapper;
  }

  function getAmountOut(
    address _tokenIn,
    uint256 _amount,
    address _tokenOut
  ) external view returns (uint256 _amountOut) {
    if (_amount == 0) revert NotEnoughAmount();
    if (_tokenIn == address(0) || _tokenOut == address(0)) revert InvalidToken();

    (address _token0, address _token1) = _tokenIn < _tokenOut ? (_tokenIn, _tokenOut) : (_tokenOut, _tokenIn);

    //Pairs have priority over tokens, and tokens over default
    if (wrappers[_token0][_token1] != address(0)) {
      _amountOut = IOracle(wrappers[_token0][_token1]).quote(_tokenIn, _amount, _tokenOut);
    } else if (wrappers[address(0)][_tokenIn] != address(0)) {
      _amountOut = IOracle(wrappers[address(0)][_tokenIn]).quote(_tokenIn, _amount, _tokenOut);
    } else {
      _amountOut = IOracle(defaultWrapper).quote(_tokenIn, _amount, _tokenOut);
    }

    return _amountOut;
  }

  function addWrapper(
    address _wrapper,
    address _tokenIn,
    address _tokenOut
  ) external onlyOwner {
    (address _token0, address _token1) = _tokenIn < _tokenOut ? (_tokenIn, _tokenOut) : (_tokenOut, _tokenIn);
    if (wrappers[_token0][_token1] != address(0)) revert WrapperExists();
    wrappers[_token0][_token1] = _wrapper;
    //Adds wrapper only if doesn't already exists
    allWrappers.add(_wrapper);
    emit WrapperAdded(_wrapper);
  }

  function setDefaultWrapper(address _wrapper) external onlyOwner {
    if (_wrapper == address(0)) revert WrapperZero();
    defaultWrapper = _wrapper;
    emit WrapperDefaultChanged(_wrapper);
  }

  function removeWrapper(
    address _wrapper,
    address _tokenIn,
    address _tokenOut
  ) external onlyOwner {
    if (wrappers[_tokenIn][_tokenOut] == address(0)) revert InvalidWrapper();
    delete wrappers[_tokenIn][_tokenOut];
    allWrappers.remove(_wrapper);
    emit WrapperRemoved(_wrapper);
  }

  function getBestPrice(address _tokenIn, address _tokenOut) external view returns (uint256 bestAmountOut) {
    if (_tokenIn == address(0) || _tokenOut == address(0)) revert InvalidToken();
    for (uint256 i = 0; i < allWrappers.length(); i++) {
      uint256 amount = IOracle(allWrappers.at(i)).quote(_tokenIn, 1 ether, _tokenOut);
      if (amount > bestAmountOut) {
        bestAmountOut = amount;
      }
    }
    return bestAmountOut;
  }
}
