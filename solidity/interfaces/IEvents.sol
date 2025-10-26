//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

interface IEvents {
  error NotEnoughAmount();
  error WrapperExists();
  error InvalidToken();
  error WrapperZero();
  error InvalidWrapper();

  event WrapperAdded(address wrapper);
  event WrapperDefaultChanged(address wrapper);
  event WrapperRemoved(address wrapper);
}
