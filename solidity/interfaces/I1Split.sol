//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

interface I1Split {
  function getExpectedReturn(
    address fromToken,
    address destToken,
    uint256 amount,
    uint256 parts,
    uint256 flags
  ) external view returns (uint256 returnAmount, uint256[] memory distribution);
}
