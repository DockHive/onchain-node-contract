# NodeMeta Contract and Interaction Scripts

This repository contains the NodeMeta contract and various scripts for deploying and interacting with it on the Base Sepolia testnet. The NodeMeta contract is designed to store and manage node metadata for DockHive, including cluster ID, weave hash, timestamp, reward, and node address.

## Overview

The NodeMeta contract is an ERC721-based contract that stores metadata about nodes. This repository includes:

- Solidity contract code for the NodeMeta contract
- Shell scripts for deploying the contract and extracting the ABI
- Information about the contract's integration with DockHive

## Contract

The `NodeMeta` contract is built on top of the Patchwork721 contract and includes additional storage and retrieval functions for node metadata. It uses the Patchwork721 framework for its base functionalities.

### Contract Structure

- `NodeMeta.sol`: The main contract file.
- `models/NodeMetaStorage.sol`: The storage model for the contract.

**Contract Address:** `0x753a6b3B9610651e87A1cf459628b956E37a7dC1`

**Testnet URL:** [testnet.dockhive.io](https://testnet.dockhive.io)

## Shell Scripts

### `deploy_contract.sh`

This shell script deploys the NodeMeta contract using `forge`. 

**Usage:**

1. **Set Up Variables**: Define the path to the deployment script, RPC URL, chain ID, and private key.
2. **Run the Script**: Execute the script to deploy the contract.

**Example:**

```bash
#!/bin/bash

# Define the private key with 0x prefix
ETH_PRIVATE_KEY="your-private-key"

# Verify that the private key is set correctly
if [[ -z "$ETH_PRIVATE_KEY" ]]; then
  echo "Private key not set correctly. Exiting."
  exit 1
fi

echo "Private key set successfully."

# Define variables for deployment
SCRIPT_PATH="deploy.s.sol"
RPC_URL="https://base-sepolia-rpc.publicnode.com"
CHAIN_ID=84532

# Function to deploy contract using forge script
deploy_contract() {
  local script_path=$1
  local rpc_url=$2
  local chain_id=$3
  local private_key=$4

  # Debug output
  echo "Deploying contract with:"
  echo "Script Path: $script_path"
  echo "RPC URL: $rpc_url"
  echo "Chain ID: $chain_id"
  echo "Private Key: $private_key"

  forge script "$script_path" --rpc-url "$rpc_url" --chain-id "$chain_id" --private-key "$private_key" --broadcast
}

# Deploy the contract
deploy_contract "$SCRIPT_PATH" "$RPC_URL" "$CHAIN_ID" "$ETH_PRIVATE_KEY"
```

### `extract_abi.sh`

This shell script extracts the ABI (Application Binary Interface) from a Solidity contract file and saves it to a specified directory.

**Usage:**

1. **Provide Contract Name**: Pass the contract file name (without the `.sol` extension) as an argument when running the script. For example, use `NodeMeta` if your contract file is named `NodeMeta.sol`.

2. **Output Directory**: The ABI file will be saved to the `abis` directory, which will be created if it does not already exist.

3. **Run the Script**: Execute the script with the contract name to generate the ABI file.

**Example:**

```bash
#!/bin/bash

# Check if a contract name is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <ContractName>"
  exit 1
fi

# Define the contract name from the argument, removing the .sol extension if present
contract_name=$(basename "$1" .sol)

# Define the output directory
OUTPUT_DIR="abis"

# Create the output directory if it does not exist
mkdir -p $OUTPUT_DIR

# Extract the ABI and save it to a file
forge inspect $contract_name abi > "$OUTPUT_DIR/$contract_name.abi"

echo "ABI for $contract_name saved to $OUTPUT_DIR/$contract_name.abi"
```

## Patchwork Integration

The `NodeMeta` contract uses the Patchwork721 framework, which provides essential functionalities for managing metadata. The contract integrates with Patchwork721 as follows:

```solidity
import "@openzeppelin/contracts/utils/Strings.sol";
import "@patchwork/Patchwork721.sol";
import "./models/NodeMetaStorage.sol";
```

- `Patchwork721` provides a base for the contract, including functions and utilities for metadata handling.
- The contract is built to be compatible with Patchwork's standards, facilitating integration with decentralized applications.

## Contributing

Feel free to contribute to this project by submitting issues or pull requests. Make sure to follow the code of conduct and provide detailed descriptions of your changes.

## License

This project is licensed under the MIT License.

