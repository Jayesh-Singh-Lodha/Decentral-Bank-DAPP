const Tether = artifacts.require("Tether");
const Reward = artifacts.require("Reward");
const DecentralBank = artifacts.require("DecentralBank");

module.exports = async function (deployer,network,accounts) {

   // Deploying Tether contract
   await deployer.deploy(Tether);
   const tether=await Tether.deployed();

   // Deploying Reward contract
   await deployer.deploy(Reward);
   const reward=await Reward.deployed();

   // Deploying DecentralBank contract
   await deployer.deploy(DecentralBank,reward.address,tether.address);
   const decentralBank=await DecentralBank.deployed();


   // Transfer all Reward Tokens to Decentral Bank
   await reward.transfer(decentralBank.address,'1000000000000000000000000');

   // Transfer Tether to invertors account
   await tether.transfer(accounts[1],'100000000000000000000');

};