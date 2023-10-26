
import { ethers } from "./ethers-5.1.esm.min.js"
import { abi } from "./constants.js"

const connectButton = document.getElementById("connectButton")
const fundButton = document.getElementById("fundButton")
connectButton.onclick = connect
fundButton.onclick = fund

console.log(ethers)

async function connect() {
    if(typeof window.ethereum !== "undefined"){
        await ethereum.request({method: "eth_requestAccounts"})
        connectButton.innerHTML = "Connected!"
    } else {
        connectButton.innerHTML = "Install metamask"
    }
}

//fund function
async function fund(ethAmount) {
    console.log(`Funding with ${ethAmount}...`)
    if(typeof window.ethereum !== "undefined") {
        //
        const provider = new ethers.providers.Web3Provider(window.ethereum)
        const signer = provider.getSigner()
        const contract = 
    }
}

//withdraw function