const MyContract = artifacts.require("spu");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(MyContract);
};