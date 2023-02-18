start-ethereum-execution-mainnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/ethereum/execution.yaml \
	--extra-vars @secrets/common.json \
	--extra-vars @extra_vars/common.json \
	--extra-vars @extra_vars/mainnet.json

start-ethereum-execution-testnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/ethereum/execution.yaml \
	--extra-vars @secrets/common.json \
	--extra-vars @extra_vars/common.json \
	--extra-vars @extra_vars/testnet.json

start-ethereum-consensus-mainnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/ethereum/consensus.yaml \
	--extra-vars @secrets/common.json \
	--extra-vars @extra_vars/common.json \
	--extra-vars @extra_vars/mainnet.json

start-ethereum-consensus-testnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/ethereum/consensus.yaml \
	--extra-vars @secrets/common.json \
	--extra-vars @extra_vars/common.json \
	--extra-vars @extra_vars/testnet.json

start-bundler-sidecar-mainnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/bundler/sidecar.yaml \
	--extra-vars @secrets/common.json \
	--extra-vars @extra_vars/common.json \
	--extra-vars @extra_vars/mainnet.json

start-bundler-sidecar-testnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/bundler/sidecar.yaml \
	--extra-vars @secrets/common.json \
	--extra-vars @extra_vars/common.json \
	--extra-vars @extra_vars/testnet.json

start-bundler-logging-mainnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/bundler/logging.yaml \
	--extra-vars @secrets/common.json \
	--extra-vars @extra_vars/common.json \
	--extra-vars @extra_vars/mainnet.json

start-bundler-logging-testnet:
	ansible-playbook \
	-i inventory.yaml ./playbooks/bundler/logging.yaml \
	--extra-vars @secrets/common.json \
	--extra-vars @extra_vars/common.json \
	--extra-vars @extra_vars/testnet.json
