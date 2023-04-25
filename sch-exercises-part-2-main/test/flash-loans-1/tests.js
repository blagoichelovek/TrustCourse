const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("Flash Loan Exercise 1", function () {
  let deployer, user;
  const POOL_BALANCE = ethers.utils.parseEther("1000");

  it("Flash Loan Tests", async function () {
    /** CODE YOUR SOLUTION HERE */

    // TODO: Deploy Pool.sol contract with 1,000 ETH
    const Pool = await ethers.getContractFactory("Pool", deployer);
    const pool = await Pool.deploy({ value: POOL_BALANCE });
    // TODO: Deploy Receiver.sol contract
    const Receiver = await ethers.getContractFactory("Receiver", user);
    const receiver = await Receiver.deploy(pool.address);
    // TODO: Successfuly execute a Flash Loan of all the balance using Receiver.sol contract
    await receiver.flashLoan(POOL_BALANCE);
    // TODO: Deploy GreedyReceiver.sol contract
    const GreedyReceiver = await ethers.getContractFactory(
      "GreedyReceiver",
      user
    );
    const greedyReceiver = await GreedyReceiver.deploy(pool.address);
    // TODO: Fails to execute a flash loan with GreedyReceiver.sol contract
    await expect(greedyReceiver.flashLoan(POOL_BALANCE)).to.be.revertedWith(
      "Flash loan hasn't been paid back"
    );
  });
});
