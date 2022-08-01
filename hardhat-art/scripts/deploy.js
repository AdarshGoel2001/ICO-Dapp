const { ethers } = require("hardhat");
const { NFT_CONTRACT_ADDRESS } = require("../constants");

async function main() {
  const cryptoDevsTokenContract = await ethers.getContractFactory(
    "CryptoDevTokens"
  );

  const deployedCryptoDevsTokenContract = await cryptoDevsTokenContract.deploy(
    NFT_CONTRACT_ADDRESS
  );
  console.log(
    "Token contract deployed to ",
    deployedCryptoDevsTokenContract.address
  );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

//deployed to 0xdF215B50C2B00FfE249E400C2eE6865f8c493AfA
