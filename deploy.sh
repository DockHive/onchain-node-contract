#!/bin/bash

# Define the private key with 0x prefix
ETH_PRIVATE_KEY=""

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
