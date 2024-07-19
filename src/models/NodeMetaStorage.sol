// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@patchwork/PatchworkUtils.sol";

contract NodeMetaStorage {

    struct Metadata {
        string clusterId;
        string weaveHash;
        string timestamp;
        uint256 reward;
        address nodeAddress;
    }

    // Functions to pack and unpack metadata
    function packMetadata(Metadata memory data) public pure returns (uint256[] memory slots) {
        uint256[] memory slots = new uint256[](5);

        slots[0] = PatchworkUtils.strToUint256(data.clusterId);
        slots[1] = PatchworkUtils.strToUint256(data.weaveHash);
        slots[2] = PatchworkUtils.strToUint256(data.timestamp);
        slots[3] = uint256(data.reward);
        slots[4] = uint256(uint160(data.nodeAddress));
        return slots;
    }

    function unpackMetadata(uint256[] memory slots) public pure returns (Metadata memory data) {
        data.clusterId = PatchworkUtils.toString32(slots[0]);
        data.weaveHash = PatchworkUtils.toString32(slots[1]);
        data.timestamp = PatchworkUtils.toString32(slots[2]);
        data.reward = uint256(slots[3]);
        data.nodeAddress = address(uint160(slots[4]));
        return data;
    }

    // Functions for metadata operations
    function storeMetadata(uint256 tokenId, Metadata memory data) public virtual {
        revert("storeMetadata function should be implemented in inheriting contracts");
    }

    function loadMetadata(uint256 tokenId) public view virtual returns (Metadata memory data) {
        revert("loadMetadata function should be implemented in inheriting contracts");
    }
}
