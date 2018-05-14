module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!

  networks: {
    development: {
      host: "localhost",
      port: 7545,
	gas: 4712388,
      network_id: "*" // Match any network id
    }
  }

};
