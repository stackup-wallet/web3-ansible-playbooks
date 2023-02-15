start-ethereum-execution-mainnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/ethereum/execution.yaml \
	--extra-vars @extra_vars/mainnet.json

start-ethereum-execution-testnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/ethereum/execution.yaml \
	--extra-vars @extra_vars/testnet.json

start-ethereum-consensus-mainnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/ethereum/consensus.yaml \
	--extra-vars @extra_vars/mainnet.json

start-ethereum-consensus-testnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/ethereum/consensus.yaml \
	--extra-vars @extra_vars/testnet.json

start-bundler-sidecar-testnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/bundler/sidecar.yaml \
	--extra-vars @extra_vars/testnet.json
