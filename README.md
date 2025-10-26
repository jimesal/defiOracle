# Price Oracle for Automated Market Makers

### Smart Contract Integration Project

---

## Project Overview

This project implements a **Price Oracle** designed to aggregate and provide reliable, real-time token pricing information across multiple **Automated Market Maker (AMM)** platforms.  
The solution was developed as part of a practical study on decentralized finance infrastructure and focuses on the **engineering and implementation** aspects of an interoperable oracle system using **Smart Contracts**.

The system retrieves on-chain price data directly from decentralized exchanges and aggregators such as **Uniswap V2**, **Uniswap V3**, **Sushiswap**, **1inch**, **Curve**, and **Chainlink**.  
It allows developers or automated agents to query and compare exchange rates between token pairs, selecting the most favorable swap conditions.

---

## Project Scope and Objectives

The objective of the project was to **design and implement** an Oracle capable of returning **accurate and up-to-date pricing** for token pairs across multiple decentralized protocols.  
The oracle was conceived as a **modular, extensible system** composed of smart contracts written in **Solidity**, capable of being deployed and queried directly on-chain.

### Core Functionalities

- **R1 – Retrieve Token Pair Price:**  
  Returns the swap ratio for a pair of crypto assets (A/B), based on their smart contract addresses.

- **R2 – Best Price Discovery:**  
  Compares prices across all registered sources and returns the most favorable exchange rate.

- **R3 – Add Price Source:**  
  Allows new data sources (DEX protocols) to be dynamically integrated into the oracle registry.

- **R4 – Remove Price Source:**  
  Enables the removal of sources from which the oracle collects data.

- **R5 – Retrieve Price from Specific Source:**  
  Returns the price of a token or swap pair from a chosen liquidity source.

- **R6 – Set Default Data Source:**  
  Defines a default protocol to ensure that all queries produce a valid price response.

The design intentionally omits any front-end or user interface, emphasizing **direct smart contract invocation**.  
This decision prioritizes on-chain efficiency and transparency over graphical presentation.

---

## System Architecture

The system is built using a **modular architecture** consisting of three main components:

1. **Data Sources Module:**  
   Interfaces with AMM protocols and Chainlink feeds.

2. **Oracle Core Module:**  
   Processes incoming requests, computes prices, and maintains the registry of data sources.

3. **Registry Module:**  
   Handles configuration, default source assignment, and data consistency.

---

## Installation and Setup

To install and execute the implementation on a new environment, follow these steps (as outlined in Annex 2 of the report):

### 1. Install Node.js

Ensure Node.js is installed.  
Download it from:  
[https://nodejs.org/en/download](https://nodejs.org/en/download)

### 2. Clone the Boilerplate Repository

Choose a root directory and clone the Solidity boilerplate used as the base for this project (includes Hardhat):

```bash
git clone https://github.com/defi-wonderland/solidity-boilerplate.git
```

### 3. Install Dependencies with Yarn

Navigate into the cloned directory and install dependencies:

```bash
yarn install
```

### 4. Install External Libraries

#### a) Uniswap V3 Libraries

Install the Uniswap core and periphery packages directly from the GitHub repositories:

```bash
npm i https://github.com/lbertenasco/uniswap-v3-core.git
npm i https://github.com/lbertenasco/uniswap-v3-periphery.git
```

#### b) Chainlink and Sushiswap Dependencies

Install additional libraries used by the oracle:

```bash
npm i @chainlink/contracts
npm i @sushiswap/core
```

### 5. Configure Environment Variables

Duplicate the `.env.example` file as `.env` and configure your Ethereum mainnet provider.  
For this project, **Infura** was used as the access provider:

```bash
NODE_URI_MAINNET=https://mainnet.infura.io/v3/YOUR_PROJECT_KEY
```

You can create a free Infura account at [https://infura.io](https://infura.io).

---

### 6. Configure eth-sdk

Inside the `eth-sdk` module, open the `config.ts` file and include the contract addresses you intend to query.  
Then export the types with the following command:

```bash
yarn eth-sdk
```

### 7. Add Smart Contracts and Tests

Copy the smart contracts and test files from the `solidity` directory of this project into the respective folders:

```bash
solidity/contracts/
solidity/test/
```

### 8. Compile and Test

To compile the contracts:

```bash
yarn compile
```

To run the test suites:

```bash
yarn test:unit
yarn test:e2e
```

## Testing and Simulation

Unit and integration tests validate:

- Correct price retrieval per source
- Best price computation
- Dynamic source registration and removal
- Oracle fallback behavior using default data sources

These tests confirm that the oracle can dynamically manage and query decentralized exchange sources to deliver consistent price data.

---

## Future Development

Further work could focus on:

- Expanding source coverage to new AMMs
- Integrating aggregation algorithms for more advanced pricing logic
- Deploying the oracle to additional EVM-compatible networks

---

## Acknowledgments

This implementation was based on the **Defi Wonderland Solidity Boilerplate** and integrates open-source libraries from **Uniswap**, **Sushiswap**, and **Chainlink**.  
It was developed as a practical case study on **cross-protocol price discovery** within decentralized markets.
