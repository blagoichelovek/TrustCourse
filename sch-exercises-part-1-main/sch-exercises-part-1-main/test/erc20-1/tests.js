const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("ERC20 Tokens Exercise 1", function () {
  let deployer, user1, user2, user3;

  // Constants
  const DEPLOYER_MINT = ethers.utils.parseEther("100000");
  const USERS_MINT = ethers.utils.parseEther("5000");
  const FIRST_TRANSFER = ethers.utils.parseEther("100");
  const SECOND_TRANSFER = ethers.utils.parseEther("1000");

  before(async function () {
    /** Deployment and minting tests */

    [deployer, user1, user2, user3] = await ethers.getSigners();

    const BlagoToken = await ethers.getContractFactory("BlagoiToken", deployer);
    this.token = await BlagoToken.deploy();

    await this.token.mint(deployer.address, DEPLOYER_MINT);
    await this.token.mint(user1.address, USERS_MINT);
    await this.token.mint(user2.address, USERS_MINT);
    await this.token.mint(user3.address, USERS_MINT);

    expect(await this.token.balanceOf(deployer.address)).to.equal(
      DEPLOYER_MINT
    );
    expect(await this.token.balanceOf(user2.address)).to.equal(USERS_MINT);
  });

  it("Transfer tests", async function () {
    /** Transfers Tests */
    await this.token.connect(user2).transfer(user3.address, FIRST_TRANSFER);
    await this.token.connect(user3).approve(user1.address, SECOND_TRANSFER);
    expect(await this.token.allowance(user3.address, user1.address)).to.equal(
      SECOND_TRANSFER
    );
    await this.token
      .connect(user1)
      .transferFrom(user3.address, user1.address, SECOND_TRANSFER);
    expect(await this.token.balanceOf(user1.address)).to.equal(
      USERS_MINT.add(SECOND_TRANSFER)
    );
    expect(await this.token.balanceOf(user2.address)).to.equal(
      USERS_MINT.sub(FIRST_TRANSFER)
    );
    expect(await this.token.balanceOf(user3.address)).to.equal(
      USERS_MINT.add(FIRST_TRANSFER).sub(SECOND_TRANSFER)
    );
  });
});
