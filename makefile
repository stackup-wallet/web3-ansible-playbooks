start-ethereum-execution-mainnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/ethereum/execution.yaml \
	--extra-vars @extra_vars/mainnet.json

start-ethereum-execution-testnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/ethereum/execution.yaml \
	--extra-vars @extra_vars/testnet.json
