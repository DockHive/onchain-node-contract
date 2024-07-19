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
