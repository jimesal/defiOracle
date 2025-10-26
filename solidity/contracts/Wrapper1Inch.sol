//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

import 'solidity/interfaces/I1Split.sol';

contract Wrapper1Inch {
  address immutable oneSplit;

  constructor(address _oneSplit) {
    oneSplit = _oneSplit;
  }

  function quote(
    address _tokenIn,
    uint256 _amount,
    address _tokenOut
  ) external view returns (uint256 amountOut) {
    (amountOut, ) = I1Split(oneSplit).getExpectedReturn(_tokenIn, _tokenOut, _amount, 1, 0);
  }
}
