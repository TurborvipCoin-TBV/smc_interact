import { expect } from "chai";
import { ethers } from "hardhat";
import { Contract } from '@ethersproject/contracts';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import * as chai from "chai";
const chaiAsPromised = require('chai-as-promised');
chai.use(chaiAsPromised);
import { keccak256 } from 'ethers/lib/utils';

function parseEther(amount: Number) {
  return ethers.utils.parseUnits(amount.toString(), 18);
}

describe("HeroMarketplace", function () {
  let owner: SignerWithAddress,
    alice: SignerWithAddress,
    bob: SignerWithAddress,
    carol: SignerWithAddress;

    let market:Contract;
    let token:Contract;
    let nft:Contract;

  beforeEach(async () => {
    await ethers.provider.send("hardhat_reset", []);
    [owner, alice, bob, carol] = await ethers.getSigners();

    const Nft = await ethers.getContractFactory("Hero");
    nft = await Nft.deploy();

    const Token = await ethers.getContractFactory("Turborvip", owner);
    token = await Token.deploy();

    const Market = await ethers.getContractFactory("HeroMarketplace");
    market = await Market.deploy(nft.address,token.address);

    await market.setToken(nft.address);        
  })

  //// Happy Path
//   it("Buy nft", async () => {
//     expect(await crowdSale.buyTokenByUSDT(1)).revertedWith('Insufficient account balance');
//   });
});