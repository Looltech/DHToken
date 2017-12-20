var DHFixedToken = artifacts.require('./DHFixedToken.sol')

module.exports = deployer => {
  deployer.deploy(DHFixedToken, 1000)
}
