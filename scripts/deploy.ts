import { ethers, hardhatArguments } from 'hardhat';
import * as Config from './config';

async function main() {
    await Config.initConfig();
    const network = hardhatArguments.network ? hardhatArguments.network : 'dev';
    const [deployer] = await ethers.getSigners();
    console.log('deploy from address: ', deployer.address);


    // const Turborvip = await ethers.getContractFactory("Turborvip");
    // const turborvip = await Turborvip.deploy();
    // console.log('Turborvip address: ', turborvip.address);
    // Config.setConfig(network + '.Turborvip', turborvip.address);

    // const Vault = await ethers.getContractFactory("Vault");
    // const vault = await Vault.deploy();
    // console.log('Vault address: ', vault.address);
    // Config.setConfig(network + '.Vault', vault.address);
    
    // const USDT = await ethers.getContractFactory("USDT");
    // const usdt = await USDT.deploy();
    // console.log('USDT address: ', usdt.address);
    // Config.setConfig(network + '.USDT', usdt.address);

    // const Ico = await ethers.getContractFactory("TBVCrowdSale");
    // const ico = await Ico.deploy(1000,10000,'0x078CA84588a49d2BcFf404a03DadAfa03A9C1719', '0x8905cE4f0a88d1c0aadc7eE5cA37C79FCa0EBc48');
    // console.log('ICO address: ', ico.address);
    // Config.setConfig(network + '.Ico', ico.address);

    // const Hero = await ethers.getContractFactory("Hero");
    // const hero = await Hero.deploy();
    // console.log('stman hero address: ', hero.address);
    // Config.setConfig(network + '.Hero', hero.address);

    // const MKP = await ethers.getContractFactory("HeroMarketplace");
    // const heroMarketplace = await MKP.deploy("0xb9727D562012cCF800a5e44b245DA0DA8d6B6E86", "0x8905cE4f0a88d1c0aadc7eE5cA37C79FCa0EBc48");
    // console.log('Market deployed at: ', heroMarketplace.address);
    // Config.setConfig(network + '.HeroMarketplace', heroMarketplace.address);

    // const AnimeNft = await ethers.getContractFactory("AnimeNftContract");
    // const animeNft = await AnimeNft.deploy("ANIMENFT","TUV");
    // await animeNft.deployed();
    // Config.setConfig(network + '.AnimeNft', animeNft.address);
    // await animeNft.mint("https://ipfs.io/ipfs/QmebbkLR3NShCH8x6Dt5PfFnksTUKAgYGnXwWGSGGs2b3f?_gl=1*yf8vnj*_ga*NDUwNDI3MzQ0LjE2OTg3NDczODY.*_ga_5RMPXG14TE*MTcwMDcwODA2Ny4xLjEuMTcwMDcwODY1OS4yNy4wLjA.");
    // console.log('NFT address: ', animeNft.address);

    // const Auction = await ethers.getContractFactory("Auction");
    // const auction = await Auction.deploy("0xd54D6d5BD983a6cA18F8820f80E0A970FE4A9a8c", "0x65f00a282A58B30f8376D41832d76CeCB7b6186C");
    // console.log('Market deployed at: ', auction.address);
    // Config.setConfig(network + '.Auction', auction.address);

    await Config.updateConfig();
    
}

main().then(() => process.exit(0))
    .catch(err => {
        console.error(err);
        process.exit(1);
});