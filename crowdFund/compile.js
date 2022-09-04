const path = require('path')
const solc = require('solc');
const fs = require('fs-extra')

const buildPath = path.resolve(__dirname, 'build')
fs.removeSync(buildPath)

const campaignPath = path.resolve(__dirname, 'contracts', 'campaign.sol')
const source = fs.readFileSync(campaignPath, 'utf8')


var input = {
    language: 'Solidity',
    sources: {
        'campaign.sol': {
            content: source
        }
    },
    settings: {
        outputSelection: {
            '*': {
                '*': ['*']
            }
        }
    }
};

var output = JSON.parse(solc.compile(JSON.stringify(input))).contracts['campaign.sol'];

fs.ensureDirSync(buildPath)

for (let contract in output) {
    fs.outputJSON(
        path.resolve(buildPath, contract + '.json'),
        output[contract]
    )
}

module.exports = output
