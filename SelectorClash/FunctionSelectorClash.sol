// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract FunctionSelectorClash {
    constructor() payable {}

    function execute(string calldata _func, bytes calldata _data) external {
        require(
            !equal(_func, "transfer(address,uint256)"),
            "call to transfer not allowed"
        );

        bytes4 sig = bytes4(keccak256(bytes(_func)));

        (bool ok, ) = address(this).call(abi.encodePacked(sig, _data));
        require(ok, "tx failed");
    }

    function transfer(address payable _to, uint256 _amount) external {
        require(msg.sender == address(this), "not authorized");
        _to.transfer(_amount);
    }

    function equal(
        string memory a,
        string memory b
    ) private pure returns (bool) {
        return keccak256(abi.encode(a)) == keccak256(abi.encode(b));
    }
}
