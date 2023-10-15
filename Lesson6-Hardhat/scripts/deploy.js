//imports
const { ethers, run, network } = require("hardhat")

async function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}


//async function
async function main() {
  const SimpleStorageFactory = await ethers.deployContract(
    "SimpleStorage"
  )

  console.log("Deploying contract...")
  await SimpleStorageFactory.waitForDeployment()

  console.log(`Deployed contract to: ${SimpleStorageFactory.target}`)

  if (network.config.chainId === 11155111 && process.env.ETHERSCAN_API_KEY){
    await sleep(30 * 1000);
    await verify(SimpleStorageFactory.target, [])
  }

  const currentValue = await SimpleStorageFactory.retrieve()
  console.log(`Current Value is: ${currentValue}`)

  //Update currentValue
  const transactionResponse = await SimpleStorageFactory.store(7)
  await sleep(30 * 1000)
  const updatedValue = await SimpleStorageFactory.retrieve()

  console.log(`Updated Value is: ${updatedValue}`)
}

async function verify(contractAddress, args) {
  console.log("Verifying contract...")
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    })
  } catch (e) {
    if (e.message.toLoerCase().includes("already verified")) {
      console.log("Already Verified!")
    }else {
      console.log(e)
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error)
    process.exit(1)
  })