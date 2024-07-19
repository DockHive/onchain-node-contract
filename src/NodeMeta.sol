// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@patchwork/Patchwork721.sol";
import "./models/NodeMetaStorage.sol";

contract NodeMeta is Patchwork721, NodeMetaStorage {

    // Array to keep track of all token IDs
    uint256[] private allTokenIds;

    constructor(address _manager, address _owner)
        Patchwork721("NodeActivities", "NodeMeta", "EXC", _manager, _owner)
    {}

    function schemaURI() pure external override returns (string memory) {
        return "https://onchain.dockhive.app/schemas/schema.json";
    }

    function imageURI(uint256 tokenId) pure external override returns (string memory) {
        return string.concat("https://onchain.dockhive.app/images/", Strings.toString(tokenId), ".png");
    }

    function _baseURI() internal pure virtual override returns (string memory) {
        return "";
    }

    // Use the inherited _metadataStorage from Patchwork721
    function storeMetadata(uint256 tokenId, Metadata memory data) public override {
        if (!_checkTokenWriteAuth(tokenId)) {
            revert IPatchworkProtocol.NotAuthorized(msg.sender);
        }
        _metadataStorage[tokenId] = packMetadata(data);
        allTokenIds.push(tokenId);  // Track the new token ID
    }

    function loadMetadata(uint256 tokenId) public view override returns (Metadata memory data) {
        return unpackMetadata(_metadataStorage[tokenId]);
    }

    function schema() pure external override returns (MetadataSchema memory) {
        MetadataSchemaEntry[] memory entries = new MetadataSchemaEntry[](5);
        entries[0] = MetadataSchemaEntry(1, 0, FieldType.CHAR32, 1, FieldVisibility.PUBLIC, 0, 0, "clusterId");
        entries[1] = MetadataSchemaEntry(3, 0, FieldType.CHAR32, 1, FieldVisibility.PUBLIC, 1, 0, "weaveHash");
        entries[2] = MetadataSchemaEntry(4, 0, FieldType.CHAR32, 1, FieldVisibility.PUBLIC, 2, 0, "timestamp");
        entries[3] = MetadataSchemaEntry(5, 0, FieldType.UINT256, 1, FieldVisibility.PUBLIC, 3, 0, "reward");
        entries[4] = MetadataSchemaEntry(2, 0, FieldType.ADDRESS, 1, FieldVisibility.PUBLIC, 4, 0, "nodeAddress");
        return MetadataSchema(1, entries);
    }

    function loadClusterId(uint256 tokenId) public view returns (string memory) {
        uint256 value = uint256(_metadataStorage[tokenId][0]);
        return PatchworkUtils.toString32(value);
    }

    function storeClusterId(uint256 tokenId, string memory clusterId) public {
        if (!_checkTokenWriteAuth(tokenId)) {
            revert IPatchworkProtocol.NotAuthorized(msg.sender);
        }
        _metadataStorage[tokenId][0] = PatchworkUtils.strToUint256(clusterId);
    }

    function loadWeaveHash(uint256 tokenId) public view returns (string memory) {
        uint256 value = uint256(_metadataStorage[tokenId][1]);
        return PatchworkUtils.toString32(value);
    }

    function storeWeaveHash(uint256 tokenId, string memory weaveHash) public {
        if (!_checkTokenWriteAuth(tokenId)) {
            revert IPatchworkProtocol.NotAuthorized(msg.sender);
        }
        _metadataStorage[tokenId][1] = PatchworkUtils.strToUint256(weaveHash);
    }

    function loadTimestamp(uint256 tokenId) public view returns (string memory) {
        uint256 value = uint256(_metadataStorage[tokenId][2]);
        return PatchworkUtils.toString32(value);
    }

    function storeTimestamp(uint256 tokenId, string memory timestamp) public {
        if (!_checkTokenWriteAuth(tokenId)) {
            revert IPatchworkProtocol.NotAuthorized(msg.sender);
        }
        _metadataStorage[tokenId][2] = PatchworkUtils.strToUint256(timestamp);
    }

    function loadReward(uint256 tokenId) public view returns (uint256) {
        uint256 value = uint256(_metadataStorage[tokenId][3]);
        return uint256(value);
    }

    function storeReward(uint256 tokenId, uint256 reward) public {
        if (!_checkTokenWriteAuth(tokenId)) {
            revert IPatchworkProtocol.NotAuthorized(msg.sender);
        }
        _metadataStorage[tokenId][3] = uint256(reward);
    }

    function loadNodeAddress(uint256 tokenId) public view returns (address) {
        uint256 value = uint256(_metadataStorage[tokenId][4]);
        return address(uint160(value));
    }

    function storeNodeAddress(uint256 tokenId, address nodeAddress) public {
        if (!_checkTokenWriteAuth(tokenId)) {
            revert IPatchworkProtocol.NotAuthorized(msg.sender);
        }
        uint256 mask = (1 << 160) - 1;
        uint256 cleared = uint256(_metadataStorage[tokenId][4]) & ~(mask);
        _metadataStorage[tokenId][4] = cleared | (uint256(uint160(nodeAddress)) & mask);
    }

    // New function to get paginated metadata
    function getAllMetadata(uint256 page, uint256 pageSize) public view returns (Metadata[] memory) {
        uint256 start = page * pageSize;
        uint256 end = start + pageSize;

        if (end > allTokenIds.length) {
            end = allTokenIds.length;
        }

        Metadata[] memory paginatedMetadata = new Metadata[](end - start);

        for (uint256 i = start; i < end; i++) {
            paginatedMetadata[i - start] = unpackMetadata(_metadataStorage[allTokenIds[i]]);
        }

        return paginatedMetadata;
    }
}
