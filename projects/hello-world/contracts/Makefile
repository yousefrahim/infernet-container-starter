# phony targets are targets that don't actually create a file
.phony: deploy

# anvil's third default address
sender := 0xpv-key
RPC_URL := 0x3B1554f346DFe5c482Bb4BA31b880c1C18412170

# deploying the contract
deploy:
	@PRIVATE_KEY=$(sender) forge script script/Deploy.s.sol:Deploy --broadcast --rpc-url $(RPC_URL)

# calling sayGM()
call-contract:
	@PRIVATE_KEY=$(sender) forge script script/CallContract.s.sol:CallContract --broadcast --rpc-url $(RPC_URL)
