// module.exports = {
//   networks: {
//     development: {
//       host: "127.0.0.1",
//       port: 7545,
//       network_id: "*"
//     }
//   },
//   compilers: {
//     solc: {
//       version: "^0.8.0"
//     }
//   }
// };


require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  compilers: {
  solc: {
    version: "0.8.4",    // Change this to the version you want to use
  },
  },
  networks: {
    mainnet: {
      provider: function() {
        return new HDWalletProvider(
          "<PASSPHRASE>",
          "https://rpc.gnosischain.com"
        );
      },
      network_id: 100, // Ethereum's mainnet ID
      gas: 5500000, // You may need to tweak this
      confirmations: 2, // Number of confirmations to wait between deployments
      timeoutBlocks: 200, // Number of blocks before a deployment times out
      skipDryRun: true, // Let's you skip dry run before migrations
    },
    development: {
      provider: function() {
        return new HDWalletProvider(
          "",
          "https://rpc.gnosischain.com"
        );
      },
      network_id: 100, // Ethereum's mainnet ID
      gas: 5500000, // You may need to tweak this
      confirmations: 2, // Number of confirmations to wait between deployments
      timeoutBlocks: 200, // Number of blocks before a deployment times out
      skipDryRun: true, // Let's you skip dry run before migrations
    },

  },
};
