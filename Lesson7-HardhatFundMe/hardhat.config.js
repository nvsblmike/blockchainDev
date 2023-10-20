require("@nomicfoundation/hardhat-toolbox");
require("hardhat-deploy")
require("dotenv").config()

const SEPOLIA_RPC_URL = process.env.SEPOLIA_RPC_URL
const PRIVATE_KEY = process.env.PRIVATE_KEY
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 31337,
    },
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 11155111,
      blockConfirmations: 6,
    },
  },
  solidity: {
    compilers: [
      {
        version: "0.8.17",
      },
      {
        version: "0.8.19",
      },
    ],
  },
    etherscan: {
      apiKey: ETHERSCAN_API_KEY,
    },
    gasReporter: {
      enabled: true,
      currency: "USD",
      outputFile: "gas-report.txt",
      noColors: true,
    },
  namedAccounts: {
    deployer: {
      default: 0,
      1: 0,
    },
  },
  mocha: {
    timeout: 500000,
  },
}