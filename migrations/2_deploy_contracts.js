const ERC20Adapter = artifacts.require("ERC20Adapter");
const TokenSwap = artifacts.require("TokenSwap");

module.exports = async function (deployer, network, accounts) {
    const token1Address = "0x0Ae38f7E10A43B5b2fB064B42a2f4514cbA909ef"; // Replace with your token1 address
    const token2Address = "0xbafa44efe7901e04e39dad13167d089c559c1138"; // Replace with your token2 address

    await deployer.deploy(ERC20Adapter, token1Address);
    const token1Adapter = await ERC20Adapter.deployed();

    await deployer.deploy(ERC20Adapter, token2Address);
    const token2Adapter = await ERC20Adapter.deployed();

    await deployer.deploy(TokenSwap, token1Adapter.address, token2Adapter.address);
};
