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

describe("TBVCrowdSale", function () {
  let owner: SignerWithAddress,
    alice: SignerWithAddress,
    bob: SignerWithAddress,
    carol: SignerWithAddress;

    let crowdSale:Contract;
    let usdt:Contract;
    let icoToken:Contract;

  beforeEach(async () => {
    await ethers.provider.send("hardhat_reset", []);
    [owner, alice, bob, carol] = await ethers.getSigners();

    const IcoToken = await ethers.getContractFactory("Floppy", owner);
    icoToken = await IcoToken.deploy();

    const TokenUSDT = await ethers.getContractFactory("USDT", owner);
    usdt = await TokenUSDT.deploy();
    const TBVCrowdSale = await ethers.getContractFactory("TBVCrowdSale", owner);
    crowdSale = await TBVCrowdSale.deploy(1000,1000,'0x3fd2A3Ac8D2db9455ef5E971175B5656012Da2B7',icoToken.address);
    await crowdSale.setUSDTToken(usdt.address);        
    await crowdSale.setUSDTRate(1000);        
})

  ////// Happy Path
//   it("USDT rate", async () => {
//     console.log('ustd token :',await crowdSale.getUSDTToken())
//     console.log('before',await usdt.balanceOf(crowdSale.address))

//     let amount  = await crowdSale.getTokenAmountUSDT(1)
    
//     await usdt.transfer(crowdSale.address,parseEther(1 * 10**9));

//     console.log('after',await usdt.balanceOf(crowdSale.address))
//     console.log('amount',amount)
//     console.log('check amount',await usdt.balanceOf(crowdSale.address) > amount)

//     expect(await crowdSale.buyTokenByUSDT(1)).revertedWith('Insufficient account balance');
//   });
});