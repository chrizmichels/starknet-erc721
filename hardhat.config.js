require("@shardlabs/starknet-hardhat-plugin");
require("@nomiclabs/hardhat-waffle");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  cairo: {
    version: "0.7.0" // alternatively choose one of the two venv options below

    // uses (my-venv) defined by `python -m venv path/to/my-venv`
    // venv: "path/to/my-venv"
    
    // uses the currently active Python environment (hopefully with available Starknet commands!) 
    //venv: "active"
  },
  networks: {
    devnet: {
      url: "http://localhost:5000"
    }
  }
  
};


