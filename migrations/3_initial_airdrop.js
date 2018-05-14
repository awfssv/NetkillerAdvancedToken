var NetkillerAdvancedTokenAirDrop = artifacts.require("./NetkillerAdvancedTokenAirDrop.sol");

module.exports = function(deployer) {
  deployer.deploy(NetkillerAdvancedTokenAirDrop,1200000000,"Netkiller Reader Coin","NRC",18);
};
