const Tether = artifacts.require("Tether");
const Reward = artifacts.require("Reward");
const DecentralBank = artifacts.require("DecentralBank");

require('chai')
    .use(require('chai-as-promised'))
    .should

contract('DecentralBank', ([owner, customer]) => {

    // All of the test code goes here...

    // function for ether conversion
    function tokens(number) {
        return web3.utils.toWei(number, 'ether');
    }

    let tether, reward, decentralBank;

    before(async () => {

        // Load contracts
        tether = await Tether.new();
        reward = await Reward.new();
        decentralBank = await DecentralBank.new(reward.address, tether.address);

        // Transfer all tokens to decentralised bank (1 million)
        await reward.transfer(decentralBank.address, tokens('1000000'));

        // Transfer 100 Tethers to investors
        await tether.transfer(customer, tokens('100'), { from: owner });
    })

    describe("Mock Tether deployment", async () => {
        it("matches name successfully", async () => {
            const name = await tether.name();
            assert.equal(name, "Mock Tether Token")
        })
    })

    describe("Mock Reward deployment", async () => {
        it("matches name successfully", async () => {
            const name = await reward.name();
            assert.equal(name, "Reward Token")
        })
    })

    describe("Decentral Bank Deployment", async () => {

        it("matches name successfully", async () => {
            const name = await decentralBank.name();
            assert.equal(name, "Decentral Bank");
        })

        it("contract has tokens", async () => {
            const balance = await reward.balanceOf(decentralBank.address);
            assert.equal(balance, tokens('1000000'));
        })

    })

})