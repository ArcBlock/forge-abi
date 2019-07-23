# Status Code

## invalid_wallet

This wallet is invalid.

## storage_rpc_error

This is a storage rpc error.

## consensus_rpc_error

This transaction has already occured on the chain before.

## forbidden

Operation is not permitted with current authorization.

## account_migrated

This account has migrated to a new one.

## invalid_receiver_state

### account_migrate

Possible causes:
1. `AccountMigrateTx.address` is not correctly calculated with `AccountMigrateTx.pk` and `AccountMigrateTx.type` or the receiver does not exist on this chain.
2. `AccountMigrateTx.address` does not exist on this chain.


### consume_asset

The `signer` included in first `tx.signatures` does not exist on this chain.


### default

The receiver of this transaction does not exist on this chain.


### exchange

Either `ExchangeTx.to` or the `signer` included in first `tx.signatures` does not exist on this chain.


### poke

`PokeTx.address` is not correct or does not exist on this chain.


### stake

`tx.to` does not exist on this chain or `tx.to` is not a a valid DID address


### transfer

`TransferTx.to` does not exist on this chain.


## invalid_owner

### default

One or more of the assets included this tx do not belong to the provided owners.


## unsupported_tx

This transaction contains type_urls that are not registered on the chain.

## exceed_deposit_cap

The amount exceeds the deposit cap.

## invalid_moniker

### declare

`DeclareTx.moniker` should have at least 4 characters.


### default

This moniker is invalid.


## invalid_deposit_value

The deposit value is not valid.

## invalid_withdrawer

The withdrawer does not exist on the chain.

## invalid_multisig

This multisig is invalid.

## invalid_asset

### consume_asset

The asset included in `tx.signatures.data` is not valid.


### create_asset

Possible causes:
1. `CreateAssetTx.address` is not calculated correctly.
2. Asset parent does not have a valid state.
3. Asset already exists on the chain. This is a duplicate asset.


### default

The asset included in this transaction is invalid.


### exchange

`ExchangeTx.sender.assets` or `ExchangeTx.receiver.assets` contain invalid assets.


### transfer

'TransferTx.assets' contain invalid assets.


### update_asset

`UpdateAssetTx.address` is not a valid asset.


## invalid_custodian

The custodian does not exist on the chain.

## invalid_tx

### acquire_asset

Possible Causes:
1. Asset Factory does not have enough assets left.
2. This transaction's sender does not have enough balance.
3. The asset addresses included in `AcquireAssetTx.specs` are not correct.


### consume_asset

The issuer of the asset to be consumed, should be the same as or issued by `ConsumeAsset.issuer`.


### create_asset

If `tx.data` contains `AssetFactory`, possible causes:
1. `AssetFactory.description`, `AssetFactory.attributes`, `AssetFactory.price`, `AssetFactory.template`, `AssetFactory.allowed_spec_args`, `AssetFactory.asset_name` can not be empty.
2. `AssetFactory.template` and `AssetFactory.sllowed_spec_args` should match.
3. `AssetFactory.asset_name` should contain a deployed protobuf type.


### declare

Possible Causes:
1. The signer in `tx.signatures` should be the same as `DeclareTx.issuer`.
2. This chain requires a valid issuer to declare a new account.


### default

The transaction cannot pass sanity check. Possible Causes:
  1. Anti Land Attack: Sender and receiver address should not be equal
  2. Anti Replay Attack: This transaction has been seen in the chain and is treated as a replay tx.
  3. decode tx: This transaction includes `type-url` that can not be decoded properly.
  4. verify date: the transaction is expired.
  5. verify itx size: The size of itx in this transaction exceeds max size.
  6. verify signer: the multisig signer is invalid
  7. verify tx size: The size of this transaction exceeds max size.
  8. pre_pipeline extract signers: the multisig signer is invalid


### deploy_protocol

Possible causes:
1. Sender should be moderator
2. `DeployProtocolTx.address`, `DeployProtocolTx.name`, `DeployProtocolTx.namespace`, `DeployProtocolTx.code` should not be empty. The size of `DeployProtocolTx.description` should not exceed max size.
3. `DeployProtocolTx.address` should be correctly calculated using `DeployProtocolTx`.
4. `type_url` and the module doesn't match.
5. the binary of the protocol is modified on purpose.
6. Version of new protocol should be bigger than the old ones.


### stake

1. `StakeTx.address` should be calculated from `tx.from` and `StakeTx.to`.
2. `StakeTx.message` should not exceed the max size.


### update_asset

If `tx.data` contains `AssetFactory`, 'AssetFactory.price', `AssetFactory.template`. `AssetFactory.allowed_spec_args` and `AssetFactory.asset_name` can not be empty.


### upgrade_node

Possible causes:
1. `tx.from` should be the same as moderator address
2. `UpgradeNodeTx.version` should be bigger than forge version
3. `UpgradeNodeTx.height` should be bigger than current block height.
4. an existing upgrade_node operation is going to be carried out while the new upgrade_node tx has no `override` flag.


## internal

Internal error occurred - mainly a server implementation issue.

## invalid_expiry_date

The expiry date is invalid.

## expired_wallet_token

The token included in this transaction has expired.

## untransferrable_asset

This asset can not be transferred.

## insufficient_stake

The require stake amount should be more than minimum stake.

## invalid_depositor

The depositor does not exist on the chain.

## invalid_lock_status

The lock status is invalid.

## invalid_passphrase

### default

This passphrase is invalid.


## unsupported_stake

This stake is not supported.

## insufficient_data

### account_migrate

`AccountMigrateTx.pk`, `AccountMigrateTx.type`, and `AccountMigrateTx.address` can not be empty.


### acquire_asset

`AcquireAssetTx.specs` can not be empty.


### consume_asset

`ConsumeAssetTx.issuer` and `Tx.signatures` can not be empty.


### create_asset

`CreateAssetTx.data` and `CreateAssetTx.address` can not be empty.


### declare

`DelcareTx.moniker` can not be empty.


### default

There is some required data missing to construct this transaction properly.


### exchange

`ExchangeTx.sender`, `ExchangeTx.receiver`, and `Tx.signatures` can not be empty.


### poke

`PokeTx.date` and `PokeTx.address` can not be empty.


### stake

`StakeTx.to`, `StakeTx.value`, `StakeTx.data`, `StakeTx.address` can not be empty.


### transfer

`TransferTx.to`, `TransferTx.value`/`TransferTx.asset` can not be empty.


### update_asset

`UpdateAssetTx.data` and `UpdateAssetTx.address` can not be empty.


## noent

Noent

## invalid_chain_id

This chain_id is invalid.

## expired_tx

This transaction has expired.

## invalid_deposit

The depoisit is invalid.

## invalid_tx_size

The size of `tx.itx` should be smaller than max size.


## invalid_nonce

### default

This transaction has been seen in the chain and is treated as a replay tx.


### deploy_protocol

`DeployProtocolTx.nonce` must be `0`.


### poke

`PokeTx.nonce` must be `0`.


## invalid_signature

### default

This transaction's signature or multi-signature does not match the corresponding pk.


## invalid_stake_state

The required stake state is invalid.

## invalid_sender_state

### declare

`tx.from` already exist on this chain.


### default

The sender of this transaction does not exist on this chain.


## insufficient_fund

### default

There is not enough balance in participants account.


### poke

Poke account does not have enough balance.


## invalid_deposit_target

The target of this deposit is invalid.

## invalid_request

This request is invalid.

## readonly_asset

This asset is readonly and therefore can not be modified.

## invalid_forge_state

### default

The forge state is invalid.


### deploy_protocol

The forge state is invalid.


### stake

The forge state is invalid.


### upgrade_node

The forge state is invalid.


## invalid_signer_state

All signers participating in this tx should have a valid state on this chain.


## expired_asset

This asset has expired.

## duplicate_tether

The tether is duplicated.

## consumed_asset

This asset has already been consumed before.

## timeout

Operation is timeout.

## too_many_txs

There are too many transactions.

## banned_unstake

This unstake action is banned.

# Status Code

## invalid_wallet

This wallet is invalid.

## storage_rpc_error

This is a storage rpc error.

## consensus_rpc_error

This transaction has already occured on the chain before.

## forbidden

Operation is not permitted with current authorization.

## account_migrated

This account has migrated to a new one.

## invalid_receiver_state

### account_migrate

Possible causes:
1. `AccountMigrateTx.address` is not correctly calculated with `AccountMigrateTx.pk` and `AccountMigrateTx.type` or the receiver does not exist on this chain.
2. `AccountMigrateTx.address` does not exist on this chain.


### consume_asset

The `signer` included in first `tx.signatures` does not exist on this chain.


### default

The receiver of this transaction does not exist on this chain.


### exchange

Either `ExchangeTx.to` or the `signer` included in first `tx.signatures` does not exist on this chain.


### poke

`PokeTx.address` is not correct or does not exist on this chain.


### stake

`tx.to` does not exist on this chain or `tx.to` is not a a valid DID address


### transfer

`TransferTx.to` does not exist on this chain.


## invalid_owner

### default

One or more of the assets included this tx do not belong to the provided owners.


## unsupported_tx

This transaction contains type_urls that are not registered on the chain.

## exceed_deposit_cap

The amount exceeds the deposit cap.

## invalid_moniker

### declare

`DeclareTx.moniker` should have at least 4 characters.


### default

This moniker is invalid.


## invalid_deposit_value

The deposit value is not valid.

## invalid_withdrawer

The withdrawer does not exist on the chain.

## invalid_multisig

This multisig is invalid.

## invalid_asset

### consume_asset

The asset included in `tx.signatures.data` is not valid.


### create_asset

Possible causes:
1. `CreateAssetTx.address` is not calculated correctly.
2. Asset parent does not have a valid state.
3. Asset already exists on the chain. This is a duplicate asset.


### default

The asset included in this transaction is invalid.


### exchange

`ExchangeTx.sender.assets` or `ExchangeTx.receiver.assets` contain invalid assets.


### transfer

'TransferTx.assets' contain invalid assets.


### update_asset

`UpdateAssetTx.address` is not a valid asset.


## invalid_custodian

The custodian does not exist on the chain.

## invalid_tx

### acquire_asset

Possible Causes:
1. Asset Factory does not have enough assets left.
2. This transaction's sender does not have enough balance.
3. The asset addresses included in `AcquireAssetTx.specs` are not correct.


### consume_asset

The issuer of the asset to be consumed, should be the same as or issued by `ConsumeAsset.issuer`.


### create_asset

If `tx.data` contains `AssetFactory`, possible causes:
1. `AssetFactory.description`, `AssetFactory.attributes`, `AssetFactory.price`, `AssetFactory.template`, `AssetFactory.allowed_spec_args`, `AssetFactory.asset_name` can not be empty.
2. `AssetFactory.template` and `AssetFactory.sllowed_spec_args` should match.
3. `AssetFactory.asset_name` should contain a deployed protobuf type.


### declare

Possible Causes:
1. The signer in `tx.signatures` should be the same as `DeclareTx.issuer`.
2. This chain requires a valid issuer to declare a new account.


### default

The transaction cannot pass sanity check. Possible Causes:
  1. Anti Land Attack: Sender and receiver address should not be equal
  2. Anti Replay Attack: This transaction has been seen in the chain and is treated as a replay tx.
  3. decode tx: This transaction includes `type-url` that can not be decoded properly.
  4. verify date: the transaction is expired.
  5. verify itx size: The size of itx in this transaction exceeds max size.
  6. verify signer: the multisig signer is invalid
  7. verify tx size: The size of this transaction exceeds max size.
  8. pre_pipeline extract signers: the multisig signer is invalid


### deploy_protocol

Possible causes:
1. Sender should be moderator
2. `DeployProtocolTx.address`, `DeployProtocolTx.name`, `DeployProtocolTx.namespace`, `DeployProtocolTx.code` should not be empty. The size of `DeployProtocolTx.description` should not exceed max size.
3. `DeployProtocolTx.address` should be correctly calculated using `DeployProtocolTx`.
4. `type_url` and the module doesn't match.
5. the binary of the protocol is modified on purpose.
6. Version of new protocol should be bigger than the old ones.


### stake

1. `StakeTx.address` should be calculated from `tx.from` and `StakeTx.to`.
2. `StakeTx.message` should not exceed the max size.


### update_asset

If `tx.data` contains `AssetFactory`, 'AssetFactory.price', `AssetFactory.template`. `AssetFactory.allowed_spec_args` and `AssetFactory.asset_name` can not be empty.


### upgrade_node

Possible causes:
1. `tx.from` should be the same as moderator address
2. `UpgradeNodeTx.version` should be bigger than forge version
3. `UpgradeNodeTx.height` should be bigger than current block height.
4. an existing upgrade_node operation is going to be carried out while the new upgrade_node tx has no `override` flag.


## internal

Internal error occurred - mainly a server implementation issue.

## invalid_expiry_date

The expiry date is invalid.

## expired_wallet_token

The token included in this transaction has expired.

## untransferrable_asset

This asset can not be transferred.

## insufficient_stake

The require stake amount should be more than minimum stake.

## invalid_depositor

The depositor does not exist on the chain.

## invalid_lock_status

The lock status is invalid.

## invalid_passphrase

### default

This passphrase is invalid.


## unsupported_stake

This stake is not supported.

## insufficient_data

### account_migrate

`AccountMigrateTx.pk`, `AccountMigrateTx.type`, and `AccountMigrateTx.address` can not be empty.


### acquire_asset

`AcquireAssetTx.specs` can not be empty.


### consume_asset

`ConsumeAssetTx.issuer` and `Tx.signatures` can not be empty.


### create_asset

`CreateAssetTx.data` and `CreateAssetTx.address` can not be empty.


### declare

`DelcareTx.moniker` can not be empty.


### default

There is some required data missing to construct this transaction properly.


### exchange

`ExchangeTx.sender`, `ExchangeTx.receiver`, and `Tx.signatures` can not be empty.


### poke

`PokeTx.date` and `PokeTx.address` can not be empty.


### stake

`StakeTx.to`, `StakeTx.value`, `StakeTx.data`, `StakeTx.address` can not be empty.


### transfer

`TransferTx.to`, `TransferTx.value`/`TransferTx.asset` can not be empty.


### update_asset

`UpdateAssetTx.data` and `UpdateAssetTx.address` can not be empty.


## noent

Noent

## invalid_chain_id

This chain_id is invalid.

## expired_tx

This transaction has expired.

## invalid_deposit

The depoisit is invalid.

## invalid_tx_size

The size of `tx.itx` should be smaller than max size.


## invalid_nonce

### default

This transaction has been seen in the chain and is treated as a replay tx.


### deploy_protocol

`DeployProtocolTx.nonce` must be `0`.


### poke

`PokeTx.nonce` must be `0`.


## invalid_signature

### default

This transaction's signature or multi-signature does not match the corresponding pk.


## invalid_stake_state

The required stake state is invalid.

## invalid_sender_state

### declare

`tx.from` already exist on this chain.


### default

The sender of this transaction does not exist on this chain.


## insufficient_fund

### default

There is not enough balance in participants account.


### poke

Poke account does not have enough balance.


## invalid_deposit_target

The target of this deposit is invalid.

## invalid_request

This request is invalid.

## readonly_asset

This asset is readonly and therefore can not be modified.

## invalid_forge_state

### default

The forge state is invalid.


### deploy_protocol

The forge state is invalid.


### stake

The forge state is invalid.


### upgrade_node

The forge state is invalid.


## invalid_signer_state

All signers participating in this tx should have a valid state on this chain.


## expired_asset

This asset has expired.

## duplicate_tether

The tether is duplicated.

## consumed_asset

This asset has already been consumed before.

## timeout

Operation is timeout.

## too_many_txs

There are too many transactions.

## banned_unstake

This unstake action is banned.

# Status Code

## invalid_wallet

This wallet is invalid.

## storage_rpc_error

This is a storage rpc error.

## consensus_rpc_error

This transaction has already occured on the chain before.

## forbidden

Operation is not permitted with current authorization.

## account_migrated

This account has migrated to a new one.

## invalid_receiver_state

### account_migrate

Possible causes:
1. `AccountMigrateTx.address` is not correctly calculated with `AccountMigrateTx.pk` and `AccountMigrateTx.type` or the receiver does not exist on this chain.
2. `AccountMigrateTx.address` does not exist on this chain.


### consume_asset

The `signer` included in first `tx.signatures` does not exist on this chain.


### default

The receiver of this transaction does not exist on this chain.


### exchange

Either `ExchangeTx.to` or the `signer` included in first `tx.signatures` does not exist on this chain.


### poke

`PokeTx.address` is not correct or does not exist on this chain.


### stake

`tx.to` does not exist on this chain or `tx.to` is not a a valid DID address


### transfer

`TransferTx.to` does not exist on this chain.


## invalid_owner

### default

One or more of the assets included this tx do not belong to the provided owners.


## unsupported_tx

This transaction contains type_urls that are not registered on the chain.

## exceed_deposit_cap

The amount exceeds the deposit cap.

## invalid_moniker

### declare

`DeclareTx.moniker` should have at least 4 characters.


### default

This moniker is invalid.


## invalid_deposit_value

The deposit value is not valid.

## invalid_withdrawer

The withdrawer does not exist on the chain.

## invalid_multisig

This multisig is invalid.

## invalid_asset

### consume_asset

The asset included in `tx.signatures.data` is not valid.


### create_asset

Possible causes:
1. `CreateAssetTx.address` is not calculated correctly.
2. Asset parent does not have a valid state.
3. Asset already exists on the chain. This is a duplicate asset.


### default

The asset included in this transaction is invalid.


### exchange

`ExchangeTx.sender.assets` or `ExchangeTx.receiver.assets` contain invalid assets.


### transfer

'TransferTx.assets' contain invalid assets.


### update_asset

`UpdateAssetTx.address` is not a valid asset.


## invalid_custodian

The custodian does not exist on the chain.

## invalid_tx

### acquire_asset

Possible Causes:
1. Asset Factory does not have enough assets left.
2. This transaction's sender does not have enough balance.
3. The asset addresses included in `AcquireAssetTx.specs` are not correct.


### consume_asset

The issuer of the asset to be consumed, should be the same as or issued by `ConsumeAsset.issuer`.


### create_asset

If `tx.data` contains `AssetFactory`, possible causes:
1. `AssetFactory.description`, `AssetFactory.attributes`, `AssetFactory.price`, `AssetFactory.template`, `AssetFactory.allowed_spec_args`, `AssetFactory.asset_name` can not be empty.
2. `AssetFactory.template` and `AssetFactory.sllowed_spec_args` should match.
3. `AssetFactory.asset_name` should contain a deployed protobuf type.


### declare

Possible Causes:
1. The signer in `tx.signatures` should be the same as `DeclareTx.issuer`.
2. This chain requires a valid issuer to declare a new account.


### default

The transaction cannot pass sanity check. Possible Causes:
  1. Anti Land Attack: Sender and receiver address should not be equal
  2. Anti Replay Attack: This transaction has been seen in the chain and is treated as a replay tx.
  3. decode tx: This transaction includes `type-url` that can not be decoded properly.
  4. verify date: the transaction is expired.
  5. verify itx size: The size of itx in this transaction exceeds max size.
  6. verify signer: the multisig signer is invalid
  7. verify tx size: The size of this transaction exceeds max size.
  8. pre_pipeline extract signers: the multisig signer is invalid


### deploy_protocol

Possible causes:
1. Sender should be moderator
2. `DeployProtocolTx.address`, `DeployProtocolTx.name`, `DeployProtocolTx.namespace`, `DeployProtocolTx.code` should not be empty. The size of `DeployProtocolTx.description` should not exceed max size.
3. `DeployProtocolTx.address` should be correctly calculated using `DeployProtocolTx`.
4. `type_url` and the module doesn't match.
5. the binary of the protocol is modified on purpose.
6. Version of new protocol should be bigger than the old ones.


### stake

1. `StakeTx.address` should be calculated from `tx.from` and `StakeTx.to`.
2. `StakeTx.message` should not exceed the max size.


### update_asset

If `tx.data` contains `AssetFactory`, 'AssetFactory.price', `AssetFactory.template`. `AssetFactory.allowed_spec_args` and `AssetFactory.asset_name` can not be empty.


### upgrade_node

Possible causes:
1. `tx.from` should be the same as moderator address
2. `UpgradeNodeTx.version` should be bigger than forge version
3. `UpgradeNodeTx.height` should be bigger than current block height.
4. an existing upgrade_node operation is going to be carried out while the new upgrade_node tx has no `override` flag.


## internal

Internal error occurred - mainly a server implementation issue.

## invalid_expiry_date

The expiry date is invalid.

## expired_wallet_token

The token included in this transaction has expired.

## untransferrable_asset

This asset can not be transferred.

## insufficient_stake

The require stake amount should be more than minimum stake.

## invalid_depositor

The depositor does not exist on the chain.

## invalid_lock_status

The lock status is invalid.

## invalid_passphrase

### default

This passphrase is invalid.


## unsupported_stake

This stake is not supported.

## insufficient_data

### account_migrate

`AccountMigrateTx.pk`, `AccountMigrateTx.type`, and `AccountMigrateTx.address` can not be empty.


### acquire_asset

`AcquireAssetTx.specs` can not be empty.


### consume_asset

`ConsumeAssetTx.issuer` and `Tx.signatures` can not be empty.


### create_asset

`CreateAssetTx.data` and `CreateAssetTx.address` can not be empty.


### declare

`DelcareTx.moniker` can not be empty.


### default

There is some required data missing to construct this transaction properly.


### exchange

`ExchangeTx.sender`, `ExchangeTx.receiver`, and `Tx.signatures` can not be empty.


### poke

`PokeTx.date` and `PokeTx.address` can not be empty.


### stake

`StakeTx.to`, `StakeTx.value`, `StakeTx.data`, `StakeTx.address` can not be empty.


### transfer

`TransferTx.to`, `TransferTx.value`/`TransferTx.asset` can not be empty.


### update_asset

`UpdateAssetTx.data` and `UpdateAssetTx.address` can not be empty.


## noent

Noent

## invalid_chain_id

This chain_id is invalid.

## expired_tx

This transaction has expired.

## invalid_deposit

The depoisit is invalid.

## invalid_tx_size

The size of `tx.itx` should be smaller than max size.


## invalid_nonce

### default

This transaction has been seen in the chain and is treated as a replay tx.


### deploy_protocol

`DeployProtocolTx.nonce` must be `0`.


### poke

`PokeTx.nonce` must be `0`.


## invalid_signature

### default

This transaction's signature or multi-signature does not match the corresponding pk.


## invalid_stake_state

The required stake state is invalid.

## invalid_sender_state

### declare

`tx.from` already exist on this chain.


### default

The sender of this transaction does not exist on this chain.


## insufficient_fund

### default

There is not enough balance in participants account.


### poke

Poke account does not have enough balance.


## invalid_deposit_target

The target of this deposit is invalid.

## invalid_request

This request is invalid.

## readonly_asset

This asset is readonly and therefore can not be modified.

## invalid_forge_state

### default

The forge state is invalid.


### deploy_protocol

The forge state is invalid.


### stake

The forge state is invalid.


### upgrade_node

The forge state is invalid.


## invalid_signer_state

All signers participating in this tx should have a valid state on this chain.


## expired_asset

This asset has expired.

## duplicate_tether

The tether is duplicated.

## consumed_asset

This asset has already been consumed before.

## timeout

Operation is timeout.

## too_many_txs

There are too many transactions.

## banned_unstake

This unstake action is banned.

# Status Code

## invalid_wallet

This wallet is invalid.

## storage_rpc_error

This is a storage rpc error.

## consensus_rpc_error

This transaction has already occured on the chain before.

## forbidden

Operation is not permitted with current authorization.

## account_migrated

This account has migrated to a new one.

## invalid_receiver_state

### account_migrate

Possible causes:
1. `AccountMigrateTx.address` is not correctly calculated with `AccountMigrateTx.pk` and `AccountMigrateTx.type` or the receiver does not exist on this chain.
2. `AccountMigrateTx.address` does not exist on this chain.


### consume_asset

The `signer` included in first `tx.signatures` does not exist on this chain.


### default

The receiver of this transaction does not exist on this chain.


### exchange

Either `ExchangeTx.to` or the `signer` included in first `tx.signatures` does not exist on this chain.


### poke

`PokeTx.address` is not correct or does not exist on this chain.


### stake

`tx.to` does not exist on this chain or `tx.to` is not a a valid DID address


### transfer

`TransferTx.to` does not exist on this chain.


## invalid_owner

### default

One or more of the assets included this tx do not belong to the provided owners.


## unsupported_tx

This transaction contains type_urls that are not registered on the chain.

## exceed_deposit_cap

The amount exceeds the deposit cap.

## invalid_moniker

### declare

`DeclareTx.moniker` should have at least 4 characters.


### default

This moniker is invalid.


## invalid_deposit_value

The deposit value is not valid.

## invalid_withdrawer

The withdrawer does not exist on the chain.

## invalid_multisig

This multisig is invalid.

## invalid_asset

### consume_asset

The asset included in `tx.signatures.data` is not valid.


### create_asset

Possible causes:
1. `CreateAssetTx.address` is not calculated correctly.
2. Asset parent does not have a valid state.
3. Asset already exists on the chain. This is a duplicate asset.


### default

The asset included in this transaction is invalid.


### exchange

`ExchangeTx.sender.assets` or `ExchangeTx.receiver.assets` contain invalid assets.


### transfer

'TransferTx.assets' contain invalid assets.


### update_asset

`UpdateAssetTx.address` is not a valid asset.


## invalid_custodian

The custodian does not exist on the chain.

## invalid_tx

### acquire_asset

Possible Causes:
1. Asset Factory does not have enough assets left.
2. This transaction's sender does not have enough balance.
3. The asset addresses included in `AcquireAssetTx.specs` are not correct.


### consume_asset

The issuer of the asset to be consumed, should be the same as or issued by `ConsumeAsset.issuer`.


### create_asset

If `tx.data` contains `AssetFactory`, possible causes:
1. `AssetFactory.description`, `AssetFactory.attributes`, `AssetFactory.price`, `AssetFactory.template`, `AssetFactory.allowed_spec_args`, `AssetFactory.asset_name` can not be empty.
2. `AssetFactory.template` and `AssetFactory.sllowed_spec_args` should match.
3. `AssetFactory.asset_name` should contain a deployed protobuf type.


### declare

Possible Causes:
1. The signer in `tx.signatures` should be the same as `DeclareTx.issuer`.
2. This chain requires a valid issuer to declare a new account.


### default

The transaction cannot pass sanity check. Possible Causes:
  1. Anti Land Attack: Sender and receiver address should not be equal
  2. Anti Replay Attack: This transaction has been seen in the chain and is treated as a replay tx.
  3. decode tx: This transaction includes `type-url` that can not be decoded properly.
  4. verify date: the transaction is expired.
  5. verify itx size: The size of itx in this transaction exceeds max size.
  6. verify signer: the multisig signer is invalid
  7. verify tx size: The size of this transaction exceeds max size.
  8. pre_pipeline extract signers: the multisig signer is invalid


### deploy_protocol

Possible causes:
1. Sender should be moderator
2. `DeployProtocolTx.address`, `DeployProtocolTx.name`, `DeployProtocolTx.namespace`, `DeployProtocolTx.code` should not be empty. The size of `DeployProtocolTx.description` should not exceed max size.
3. `DeployProtocolTx.address` should be correctly calculated using `DeployProtocolTx`.
4. `type_url` and the module doesn't match.
5. the binary of the protocol is modified on purpose.
6. Version of new protocol should be bigger than the old ones.


### stake

1. `StakeTx.address` should be calculated from `tx.from` and `StakeTx.to`.
2. `StakeTx.message` should not exceed the max size.


### update_asset

If `tx.data` contains `AssetFactory`, 'AssetFactory.price', `AssetFactory.template`. `AssetFactory.allowed_spec_args` and `AssetFactory.asset_name` can not be empty.


### upgrade_node

Possible causes:
1. `tx.from` should be the same as moderator address
2. `UpgradeNodeTx.version` should be bigger than forge version
3. `UpgradeNodeTx.height` should be bigger than current block height.
4. an existing upgrade_node operation is going to be carried out while the new upgrade_node tx has no `override` flag.


## internal

Internal error occurred - mainly a server implementation issue.

## invalid_expiry_date

The expiry date is invalid.

## expired_wallet_token

The token included in this transaction has expired.

## untransferrable_asset

This asset can not be transferred.

## insufficient_stake

The require stake amount should be more than minimum stake.

## invalid_depositor

The depositor does not exist on the chain.

## invalid_lock_status

The lock status is invalid.

## invalid_passphrase

### default

This passphrase is invalid.


## unsupported_stake

This stake is not supported.

## insufficient_data

### account_migrate

`AccountMigrateTx.pk`, `AccountMigrateTx.type`, and `AccountMigrateTx.address` can not be empty.


### acquire_asset

`AcquireAssetTx.specs` can not be empty.


### consume_asset

`ConsumeAssetTx.issuer` and `Tx.signatures` can not be empty.


### create_asset

`CreateAssetTx.data` and `CreateAssetTx.address` can not be empty.


### declare

`DelcareTx.moniker` can not be empty.


### default

There is some required data missing to construct this transaction properly.


### exchange

`ExchangeTx.sender`, `ExchangeTx.receiver`, and `Tx.signatures` can not be empty.


### poke

`PokeTx.date` and `PokeTx.address` can not be empty.


### stake

`StakeTx.to`, `StakeTx.value`, `StakeTx.data`, `StakeTx.address` can not be empty.


### transfer

`TransferTx.to`, `TransferTx.value`/`TransferTx.asset` can not be empty.


### update_asset

`UpdateAssetTx.data` and `UpdateAssetTx.address` can not be empty.


## noent

Noent

## invalid_chain_id

This chain_id is invalid.

## expired_tx

This transaction has expired.

## invalid_deposit

The depoisit is invalid.

## invalid_tx_size

The size of `tx.itx` should be smaller than max size.


## invalid_nonce

### default

This transaction has been seen in the chain and is treated as a replay tx.


### deploy_protocol

`DeployProtocolTx.nonce` must be `0`.


### poke

`PokeTx.nonce` must be `0`.


## invalid_signature

### default

This transaction's signature or multi-signature does not match the corresponding pk.


## invalid_stake_state

The required stake state is invalid.

## invalid_sender_state

### declare

`tx.from` already exist on this chain.


### default

The sender of this transaction does not exist on this chain.


## insufficient_fund

### default

There is not enough balance in participants account.


### poke

Poke account does not have enough balance.


## invalid_deposit_target

The target of this deposit is invalid.

## invalid_request

This request is invalid.

## readonly_asset

This asset is readonly and therefore can not be modified.

## invalid_forge_state

### default

The forge state is invalid.


### deploy_protocol

The forge state is invalid.


### stake

The forge state is invalid.


### upgrade_node

The forge state is invalid.


## invalid_signer_state

All signers participating in this tx should have a valid state on this chain.


## expired_asset

This asset has expired.

## duplicate_tether

The tether is duplicated.

## consumed_asset

This asset has already been consumed before.

## timeout

Operation is timeout.

## too_many_txs

There are too many transactions.

## banned_unstake

This unstake action is banned.

# Status Code

## invalid_wallet

This wallet is invalid.

## storage_rpc_error

This is a storage rpc error.

## consensus_rpc_error

This transaction has already occured on the chain before.

## forbidden

Operation is not permitted with current authorization.

## account_migrated

This account has migrated to a new one.

## invalid_receiver_state

### account_migrate

Possible causes:
1. `AccountMigrateTx.address` is not correctly calculated with `AccountMigrateTx.pk` and `AccountMigrateTx.type` or the receiver does not exist on this chain.
2. `AccountMigrateTx.address` does not exist on this chain.


### consume_asset

The `signer` included in first `tx.signatures` does not exist on this chain.


### default

The receiver of this transaction does not exist on this chain.


### exchange

Either `ExchangeTx.to` or the `signer` included in first `tx.signatures` does not exist on this chain.


### poke

`PokeTx.address` is not correct or does not exist on this chain.


### stake

`tx.to` does not exist on this chain or `tx.to` is not a a valid DID address


### transfer

`TransferTx.to` does not exist on this chain.


## invalid_owner

### default

One or more of the assets included this tx do not belong to the provided owners.


## unsupported_tx

This transaction contains type_urls that are not registered on the chain.

## exceed_deposit_cap

The amount exceeds the deposit cap.

## invalid_moniker

### declare

`DeclareTx.moniker` should have at least 4 characters.


### default

This moniker is invalid.


## invalid_deposit_value

The deposit value is not valid.

## invalid_withdrawer

The withdrawer does not exist on the chain.

## invalid_multisig

This multisig is invalid.

## invalid_asset

### consume_asset

The asset included in `tx.signatures.data` is not valid.


### create_asset

Possible causes:
1. `CreateAssetTx.address` is not calculated correctly.
2. Asset parent does not have a valid state.
3. Asset already exists on the chain. This is a duplicate asset.


### default

The asset included in this transaction is invalid.


### exchange

`ExchangeTx.sender.assets` or `ExchangeTx.receiver.assets` contain invalid assets.


### transfer

'TransferTx.assets' contain invalid assets.


### update_asset

`UpdateAssetTx.address` is not a valid asset.


## invalid_custodian

The custodian does not exist on the chain.

## invalid_tx

### acquire_asset

Possible Causes:
1. Asset Factory does not have enough assets left.
2. This transaction's sender does not have enough balance.
3. The asset addresses included in `AcquireAssetTx.specs` are not correct.


### consume_asset

The issuer of the asset to be consumed, should be the same as or issued by `ConsumeAsset.issuer`.


### create_asset

If `tx.data` contains `AssetFactory`, possible causes:
1. `AssetFactory.description`, `AssetFactory.attributes`, `AssetFactory.price`, `AssetFactory.template`, `AssetFactory.allowed_spec_args`, `AssetFactory.asset_name` can not be empty.
2. `AssetFactory.template` and `AssetFactory.sllowed_spec_args` should match.
3. `AssetFactory.asset_name` should contain a deployed protobuf type.


### declare

Possible Causes:
1. The signer in `tx.signatures` should be the same as `DeclareTx.issuer`.
2. This chain requires a valid issuer to declare a new account.


### default

The transaction cannot pass sanity check. Possible Causes:
  1. Anti Land Attack: Sender and receiver address should not be equal
  2. Anti Replay Attack: This transaction has been seen in the chain and is treated as a replay tx.
  3. decode tx: This transaction includes `type-url` that can not be decoded properly.
  4. verify date: the transaction is expired.
  5. verify itx size: The size of itx in this transaction exceeds max size.
  6. verify signer: the multisig signer is invalid
  7. verify tx size: The size of this transaction exceeds max size.
  8. pre_pipeline extract signers: the multisig signer is invalid


### deploy_protocol

Possible causes:
1. Sender should be moderator
2. `DeployProtocolTx.address`, `DeployProtocolTx.name`, `DeployProtocolTx.namespace`, `DeployProtocolTx.code` should not be empty. The size of `DeployProtocolTx.description` should not exceed max size.
3. `DeployProtocolTx.address` should be correctly calculated using `DeployProtocolTx`.
4. `type_url` and the module doesn't match.
5. the binary of the protocol is modified on purpose.
6. Version of new protocol should be bigger than the old ones.


### stake

1. `StakeTx.address` should be calculated from `tx.from` and `StakeTx.to`.
2. `StakeTx.message` should not exceed the max size.


### update_asset

If `tx.data` contains `AssetFactory`, 'AssetFactory.price', `AssetFactory.template`. `AssetFactory.allowed_spec_args` and `AssetFactory.asset_name` can not be empty.


### upgrade_node

Possible causes:
1. `tx.from` should be the same as moderator address
2. `UpgradeNodeTx.version` should be bigger than forge version
3. `UpgradeNodeTx.height` should be bigger than current block height.
4. an existing upgrade_node operation is going to be carried out while the new upgrade_node tx has no `override` flag.


## internal

Internal error occurred - mainly a server implementation issue.

## invalid_expiry_date

The expiry date is invalid.

## expired_wallet_token

The token included in this transaction has expired.

## untransferrable_asset

This asset can not be transferred.

## insufficient_stake

The require stake amount should be more than minimum stake.

## invalid_depositor

The depositor does not exist on the chain.

## invalid_lock_status

The lock status is invalid.

## invalid_passphrase

### default

This passphrase is invalid.


## unsupported_stake

This stake is not supported.

## insufficient_data

### account_migrate

`AccountMigrateTx.pk`, `AccountMigrateTx.type`, and `AccountMigrateTx.address` can not be empty.


### acquire_asset

`AcquireAssetTx.specs` can not be empty.


### consume_asset

`ConsumeAssetTx.issuer` and `Tx.signatures` can not be empty.


### create_asset

`CreateAssetTx.data` and `CreateAssetTx.address` can not be empty.


### declare

`DelcareTx.moniker` can not be empty.


### default

There is some required data missing to construct this transaction properly.


### exchange

`ExchangeTx.sender`, `ExchangeTx.receiver`, and `Tx.signatures` can not be empty.


### poke

`PokeTx.date` and `PokeTx.address` can not be empty.


### stake

`StakeTx.to`, `StakeTx.value`, `StakeTx.data`, `StakeTx.address` can not be empty.


### transfer

`TransferTx.to`, `TransferTx.value`/`TransferTx.asset` can not be empty.


### update_asset

`UpdateAssetTx.data` and `UpdateAssetTx.address` can not be empty.


## noent

Noent

## invalid_chain_id

This chain_id is invalid.

## expired_tx

This transaction has expired.

## invalid_deposit

The depoisit is invalid.

## invalid_tx_size

The size of `tx.itx` should be smaller than max size.


## invalid_nonce

### default

This transaction has been seen in the chain and is treated as a replay tx.


### deploy_protocol

`DeployProtocolTx.nonce` must be `0`.


### poke

`PokeTx.nonce` must be `0`.


## invalid_signature

### default

This transaction's signature or multi-signature does not match the corresponding pk.


## invalid_stake_state

The required stake state is invalid.

## invalid_sender_state

### declare

`tx.from` already exist on this chain.


### default

The sender of this transaction does not exist on this chain.


## insufficient_fund

### default

There is not enough balance in participants account.


### poke

Poke account does not have enough balance.


## invalid_deposit_target

The target of this deposit is invalid.

## invalid_request

This request is invalid.

## readonly_asset

This asset is readonly and therefore can not be modified.

## invalid_forge_state

### default

The forge state is invalid.


### deploy_protocol

The forge state is invalid.


### stake

The forge state is invalid.


### upgrade_node

The forge state is invalid.


## invalid_signer_state

All signers participating in this tx should have a valid state on this chain.


## expired_asset

This asset has expired.

## duplicate_tether

The tether is duplicated.

## consumed_asset

This asset has already been consumed before.

## timeout

Operation is timeout.

## too_many_txs

There are too many transactions.

## banned_unstake

This unstake action is banned.

