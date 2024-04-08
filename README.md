# Task Manager

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Description

Task Manager serves basic task managing functionality all done using smart contracts and deployed on a sepolia testnet. 

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Installation

Install the node modules :
```npm i```

## Usage

You need foundry to be installed and configured in your system. 

Checkout Foundry Documentation [here](https://book.getfoundry.sh/getting-started/installation)

### Deploy the smart contracts
1. Set up the private key : ```cast wallet import defaultKey --interactive```

2. Run the Deploy script : 
```forge script scripts/DeployTaskManager.s.sol:DeployTaskManager --rpc-url <RPC_URL> --account testingKey --sender <WALLET_ADDRESS> --broadcast -vvvvv```

3. Once deployed, replace your contract address in the following file : 
```src/Contracts/scripts/addresses.js```

4. Run the Dapp : ```npm start```

## Contributing

Guidelines on how to contribute to your project, including code style, development workflow, and any other relevant information.

1. Fork the project
2. Contribute
3. Raise a PR

## License

This project is licensed under the [MIT License](LICENSE).