# Papyrus Token Bridge Smart Contracts

This repository is a fork of [POA Bridge Smart Contracts v2.2.0](https://github.com/poanetwork/poa-bridge-contracts/tree/2.2.0). Is has some minor imprevements to deploy `NATIVE-TO-ERC` type of POA Bridge over existing special ERC677 Bridge token in foreign network.

It will be very useful to read [POA Bridge documentation](https://github.com/poanetwork/poa-bridge-contracts/blob/2.2.0/README.md). It describes how the bridge works in commom and which types of work it implements. It also contains [deploy documentation](https://github.com/poanetwork/poa-bridge-contracts/blob/2.2.0/deploy/README.md) which should be read too.

# Deploy

To deploy smart contracts over existing ERC677 Bridge token it is necessary to configure file [papyrus/papyrus-bridge-contracts.env](papyrus/papyrus-bridge-contracts.env) and run docker container. To do that you need have [Docker](https://docs.docker.com/install/) and [Docker Compose](https://docs.docker.com/compose/install/) installed.

File [papyrus/papyrus-bridge-contracts.env](papyrus/papyrus-bridge-contracts.env) itself contains comments to each variable all of them are also explaned in [POA Bridge documentation](https://github.com/poanetwork/poa-bridge-contracts/blob/2.2.0/README.md). Only new added variable is `BRIDGEABLE_TOKEN_ADDRESS`. It should contain valid address of deployed ERC677 Bridge token.

To deploy bridge smart contracts just run script [papyrus/deploy-contracts.sh](papyrus/deploy-contracts.sh):

```sh
papyrus/deploy-contracts.sh
```

As result of deployment `output/deploy-result.json` file will be created. Values from this file should be used to configure Papyrus Bridge services and web dApp.

When bridge contract is deployed to home network (Papyrus Network) it necessary to send to it PPR coins with amount equal amount of currently minted existing ERC677 Bridge token (1,000,000,000 in case of PPR). These native coins will be frozen on bridge smart contract until exchange to existing ERC677 Bridge token.