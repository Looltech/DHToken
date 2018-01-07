# Test

```
cd PROJECT_FOLDER
testrpc
truffle test ./test/DHFixedToken.js
```

# Tech stack

* web3 (call Ethereum back-end)
* truffle & solidity (smart contracts)
* mochai & chai (testing)
* geth (Ethereum client)
* Metamask (client)

# Web3

* Install web3

```
yarn add web3
```

* Connect web3 to Ethereum node

```
window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"))
```

## Accounts & Balances

* Use `web3.eth.accounts` and `web3.eth.getAccounts()`
* `web3.eth`
* `web3.net`
* `web3.personal`
* `web3.db`
* `web.shh`
