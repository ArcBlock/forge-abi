prepare-travis-assets:
	@mkdir -p $(FORGE_TEST_PATH)/{tendermint,ipfs}/bin
	@mkdir -p $(TMP_DIR)/ubuntu/{tm,ipfs}
	@[ ! -f $(TMP_DIR)/ubuntu/tm/ubuntu.zip ] && curl -L -o $(TMP_DIR)/ubuntu/tm/ubuntu.zip ${tm.ubuntu} || true
	@[ ! -f $(TMP_DIR)/ubuntu/ipfs/ubuntu.tgz ] && curl -L -o $(TMP_DIR)/ubuntu/ipfs/ubuntu.tgz ${ipfs.ubuntu} || true
	@cd $(TMP_DIR)/ubuntu/tm; unzip -o ubuntu.zip
	@cp -f $(TMP_DIR)/ubuntu/tm/tendermint $(FORGE_TEST_PATH)/tendermint/bin/; chmod 755 $(FORGE_TEST_PATH)/tendermint/bin/tendermint
	@cd $(TMP_DIR)/ubuntu/ipfs; tar zxvf ubuntu.tgz
	@cp -f $(TMP_DIR)/ubuntu/ipfs/go-ipfs/ipfs $(FORGE_TEST_PATH)/ipfs/bin/; chmod 755 $(FORGE_TEST_PATH)/ipfs/bin/ipfs
