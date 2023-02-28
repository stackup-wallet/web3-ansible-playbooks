![](https://i.imgur.com/dme3YSU.png)

# Getting started

A collection of [Ansible](https://docs.ansible.com/ansible/latest/getting_started/) playbooks for provisioning web3 infrastructure on Ubuntu servers.

## Table of contents

- [Setup](#setup)
- [Commands](#commands)
  - [Ethereum](#ethereum)
    - [Setup execution client](#setup-execution-client)
    - [Setup consensus client](#setup-consensus-client)
  - [Polygon](#polygon)
    - [Setup heimdall client](#setup-heimdall-client)
    - [Setup bor client](#setup-bor-client)
  - [Bundler](#bundler)
    - [Setup bundler sidecar](#setup-bundler-sidecar)
- [License](#license)
- [Contact](#contact)

# Setup

Clone this repo into the Ansible control node. This can be anything from your local workstation or a remote server.

```bash
git clone git@github.com:stackup-wallet/web3-ansible-playbooks.git
```

Create an inventory file from the template:

```bash
cp inventory.template.yaml inventory.yaml
```

In the `inventory.yaml` file, enter the IP address or fully qualified domain name of each managed node. It should look something like this if you are using an AWS EC2 instance:

```yaml
ethereum:
  hosts:
    node01:
      ansible_host: "ubuntu@ec2-X-XXX-XXX-XXX.compute-1.amazonaws.com"
```

Create a secrets file from the template:

```bash
cp secrets/common.template.json secrets/common.json
```

Make sure to add the ssh keys to your control node's `ssh-agent`:

```bash
# If on MacOS 12 or later, replace -K with --apple-use-keychain.
 ssh-add -K ~/.ssh/you-private-key.pem
```

Run the following command to check your connection to the managed node:

```bash
ansible ethereum -m ping -i inventory.yaml
```

If it's all good, you should see the following response:

```
node01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

# Commands

Once you have your control node and `inventory.yaml` setup, you can run these commands for provisioning your managed nodes with web3 infrastructure.

All commands have both `mainnet` and `testnet` variants. For example:

```bash
# Setup Geth for mainnet
make start-ethereum-execution-mainnet

# Setup Geth for Goerli
make start-ethereum-execution-testnet
```

---

## Ethereum

Playbooks for provisioning an Ethereum full-node using [Geth](https://geth.ethereum.org/) as the execution client and [Lighthouse](https://lighthouse.sigmaprime.io/) as the consensus client.

### Setup execution client

This command will install and run Geth on all managed nodes in the `ethereum` group:

```bash
make start-ethereum-execution-testnet
```

### Setup consensus client

This command will install and run Lighthouse on all managed nodes in the `ethereum` group:

```bash
make start-ethereum-consensus-testnet
```

---

## Polygon

Playbooks for provisioning a Polygon full-node with [Heimdall](https://github.com/maticnetwork/heimdall) and [Bor](https://github.com/maticnetwork/bor). See the following links for the latest network values:

- For latest seeds and bootnodes: https://monitor.stakepool.dev.br/
- For latest snapshots: https://snapshots.polygon.technology/

### Setup Heimdall client

This command will install and run Heimdall on all managed nodes in the `polygon` group. It requires an `ethereum_host_dns` value in `secrets/common.json`.

```bash
make start-polygon-heimdall-testnet
```

To speed up sync, manually download the snapshots into `~/.heimdall_testnet/data`. See above for the latest snapshot url. The commands would look like this:

```bash
sudo service heimdalld_testnet stop

rm -rf ~/.heimdall_testnet/data && mkdir ~/.heimdall_testnet/data

wget -c https://snapshot-download.polygon.technology/heimdall-mumbai-2023-02-21.tar.gz -O - | tar -xzf - -C ~/.heimdall_testnet/data
```

Once downloaded, restart heimdall:

```bash
sudo service heimdalld_testnet start
```

### Setup Bor client

This command will install and run Bor on all managed nodes in the `polygon` group. Do not run this until Heimdall is synced. SSH into the node and run `curl localhost:26655/status` (`26657` for mainnet) and the value of `catching_up` should be false.

```bash
make start-polygon-bor-testnet
```

To speed up sync, manually download the snapshots into `~/.bor_testnet/data/bor/chaindata`. See above for the latest snapshot url. The commands would look like this:

```bash
sudo service bor_testnet stop

rm -rf ~/.bor_testnet/data/bor/chaindata && mkdir ~/.bor_testnet/data/bor/chaindata

wget -c https://snapshot-download.polygon.technology/bor-mumbai-fullnode-2023-02-21.tar.gz -O - | tar -xzf - -C ~/.bor_testnet/data/bor/chaindata
```

Once downloaded, restart bor:

```bash
sudo service bor_testnet start
```

---

## Bundler

Playbooks for provisioning an EIP-4337 Bundler using [stackup-bundler](https://github.com/stackup-wallet/stackup-bundler). This app runs as a sidecar to a full-node and will be executed on all groups.

### Setup bundler sidecar

This command requires a `private_key` value in `secrets/common.json`. It will be used by the bundler to sign transactions.

```bash
make start-bundler-sidecar-testnet
```

### Setup bundler log forwarding

This command will use [Vector](https://vector.dev/) to forward bundler logs to [Grafana Loki](https://grafana.com/oss/loki/). It requires the following values in `secrets/common.json`.

- `loki_endpoint`
- `loki_user`
- `loki_password`
- `prometheus_endpoint`
- `prometheus_user`
- `prometheus_password`

```bash
make start-bundler-logging-testnet
```

---

# License

Distributed under the GPL-3.0 License. See [LICENSE](./LICENSE) for more information.

# Contact

Feel free to direct any technical related questions to the `dev-hub` channel in the [Stackup Discord](https://discord.gg/VTjJGvMNyW).
