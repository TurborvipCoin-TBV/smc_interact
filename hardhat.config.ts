import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";
dotenv.config({path : __dirname + "/.env"});

/** @type import('hardhat/config').HardhatUserConfig */

const config: HardhatUserConfig = {
  solidity: "0.8.19",
  networks:{
    sepolia: {
      url: `https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`,
      accounts: [process.env.PRIVATE_KEY || ""]
    }
  },
  etherscan: {
    apiKey: process.env.API_KEY
  }
};

export default config;