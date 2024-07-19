// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./src/NodeMeta.sol";
import "forge-std/Script.sol";  // Import forge-std

contract DeployScript is Script {
    function run() public {
        // Address arguments for the constructor
        address patchworkProtocolAddress = 0x00000000001616E65bb9FdA42dFBb7155406549b;
        address initialOwner = 0xd63886a9cA1488b67383EC2861593b7de0778739;

        // Start broadcast
        vm.startBroadcast();

        // Deploy the contract
        NodeMeta nodeMeta = new NodeMeta(patchworkProtocolAddress, initialOwner);

        // Log the contract address
        console.log("NodeMeta deployed at:", address(nodeMeta));

        // Stop broadcast
        vm.stopBroadcast();
    }
}
