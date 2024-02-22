// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ReentrancyGuard {
    // Count stores number of times the function func was called
    uint256 public count;
    uint256 private status;
    modifier lock{
        require(status==0, "Reentrancy guard: reentrancy attempted");
        status=1;
        _;
        status=0;
    }

    function exec(address target) external lock {
        (bool ok,) = target.call("");
        require(ok, "call failed");
        count += 1;
    }
}
