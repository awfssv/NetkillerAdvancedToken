var NetkillerAdvancedToken = artifacts.require("./NetkillerAdvancedToken.sol");

module.exports = function(deployer) {
  deployer.deploy(NetkillerAdvancedToken,1200000000,"Netkiller Reader Coin","NRC",18);
};
