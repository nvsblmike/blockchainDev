const { ethers } = require("hardhat")
const { expect, assert } = require("chai")

describe("SimpleStorage", function () { 
  let simpleStorageFactory;
  beforeEach(async function () {
    simpleStorageFactory = await ethers.deployContract("SimpleStorage")
    await simpleStorageFactory.waitForDeployment()
  }) //tell us what to do before our it

  it.only("Should start with a favourite number of 0", async function() {
    const currentValue = await simpleStorageFactory.retrieve()
    const expectedValue = "0"

    assert.equal(currentValue.toString(), expectedValue)
  })

  it("Should update when we call store", async function() {
    const expectedValue = "7"
    const transactionResponse = await simpleStorageFactory.store(expectedValue)
    await transactionResponse.wait()

    const currentValue = await simpleStorageFactory.retrieve()
    assert.equal(currentValue.toString(), expectedValue)
  })
})