// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SimpleStorage {
    uint256 storedData;

    event Change(string message, uint256 newVal);

    constructor(uint256 s) public {
        storedData = s;
    }

    function set(uint256 x) public {
        storedData = x;
        emit Change("set", x);
    }

    function get() public view returns (uint256) {
        return storedData;
    }
}
