![](https://i.imgur.com/dme3YSU.png)

# Getting started

A collection of [Ansible](https://docs.ansible.com/ansible/latest/getting_started/) playbooks for provisioning web3 infrastructure.

## Table of contents

- [Setup](#setup)
- [Commands](#commands)
  - [Ethereum](#ethereum)
    - [Setup execution client](#setup-execution-client)

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
