
# NodeMeta Contract and Interaction Scripts

This repository contains the NodeMeta contract and various scripts for deploying and interacting with it on the Ethereum network.

## Overview

The NodeMeta contract is an ERC721-based contract that stores metadata about nodes. This repository includes:

- Solidity contract code for the NodeMeta contract
- Shell scripts for deploying the contract and extracting the ABI

## Contract

The `NodeMeta` contract is built on top of the Patchwork721 contract and includes additional storage and retrieval functions for node metadata.

### Contract Structure

- `NodeMeta.sol`: The main contract file.
- `models/NodeMetaStorage.sol`: The storage model for the contract.

## Shell Scripts

### `deploy_contract.sh`

This shell script deploys the NodeMeta contract using `forge`. 

To use this script:

1. Define the path to the deployment script and other parameters.
2. Run the script with appropriate arguments for the `forge` deployment.

### `extract_abi.sh`

This shell script extracts the ABI (Application Binary Interface) from a Solidity contract file and saves it to a specified directory.

To use this script:

1. **Provide Contract Name**: You need to specify the contract file name (without the `.sol` extension) as an argument when running the script. For example, if your contract file is named `NodeMeta.sol`, you would pass `NodeMeta` as the argument.

2. **Output Directory**: The script will save the extracted ABI file to the `abis` directory. This directory will be created if it does not already exist.

3. **Run the Script**: Execute the script with the contract name to generate the ABI file.

## Patchwork Integration

The `NodeMeta` contract uses the Patchwork721 framework, which requires the following imports:

```solidity
import "@openzeppelin/contracts/utils/Strings.sol";
import "@patchwork/Patchwork721.sol";
import "./models/NodeMetaStorage.sol";
```

## Contributing

Feel free to contribute to this project by submitting issues or pull requests. Make sure to follow the code of conduct and provide detailed descriptions of your changes.

## License

This project is licensed under the MIT License.

---

This README provides an overview of the project, the structure of the contract, and instructions for using the shell scripts for deployment and ABI extraction.