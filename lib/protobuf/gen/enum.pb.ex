defmodule ForgeAbi.StatusCode do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t ::
          integer
          | :ok
          | :invalid_nonce
          | :invalid_signature
          | :invalid_sender_state
          | :invalid_receiver_state
          | :insufficient_data
          | :insufficient_fund
          | :invalid_owner
          | :invalid_tx
          | :unsupported_tx
          | :expired_tx
          | :too_many_txs
          | :invalid_lock_status
          | :invalid_request
          | :invalid_moniker
          | :invalid_passphrase
          | :invalid_multisig
          | :invalid_wallet
          | :invalid_chain_id
          | :consensus_rpc_error
          | :storage_rpc_error
          | :noent
          | :account_migrated
          | :rpc_connection_error
          | :unsupported_stake
          | :insufficient_stake
          | :invalid_stake_state
          | :expired_wallet_token
          | :banned_unstake
          | :invalid_asset
          | :invalid_tx_size
          | :invalid_signer_state
          | :invalid_forge_state
          | :expired_asset
          | :untransferrable_asset
          | :readonly_asset
          | :consumed_asset
          | :invalid_deposit_value
          | :exceed_deposit_cap
          | :invalid_deposit_target
          | :invalid_depositor
          | :invalid_withdrawer
          | :invalid_expiry_date
          | :invalid_deposit
          | :invalid_custodian
          | :insufficient_gas
          | :invalid_swap
          | :invalid_hashkey
          | :invalid_delegation
          | :insufficient_delegation
          | :invalid_delegation_rule
          | :invalid_delegation_type_url
          | :sender_not_authorized
          | :protocol_not_running
          | :protocol_not_paused
          | :protocol_not_activated
          | :invalid_deactivation
          | :sender_withdraw_items_full
          | :withdraw_item_missing
          | :invalid_withdraw_tx
          | :invalid_chain_type
          | :invalid_time
          | :invalid_subscribe
          | :invalid_did_type
          | :invalid_candidate_state
          | :validator_not_found
          | :validator_not_changed
          | :forbidden
          | :internal
          | :timeout

  field :ok, 0
  field :invalid_nonce, 1
  field :invalid_signature, 2
  field :invalid_sender_state, 3
  field :invalid_receiver_state, 4
  field :insufficient_data, 5
  field :insufficient_fund, 6
  field :invalid_owner, 7
  field :invalid_tx, 8
  field :unsupported_tx, 9
  field :expired_tx, 10
  field :too_many_txs, 11
  field :invalid_lock_status, 12
  field :invalid_request, 13
  field :invalid_moniker, 16
  field :invalid_passphrase, 17
  field :invalid_multisig, 20
  field :invalid_wallet, 21
  field :invalid_chain_id, 22
  field :consensus_rpc_error, 24
  field :storage_rpc_error, 25
  field :noent, 26
  field :account_migrated, 27
  field :rpc_connection_error, 28
  field :unsupported_stake, 30
  field :insufficient_stake, 31
  field :invalid_stake_state, 32
  field :expired_wallet_token, 33
  field :banned_unstake, 34
  field :invalid_asset, 35
  field :invalid_tx_size, 36
  field :invalid_signer_state, 37
  field :invalid_forge_state, 38
  field :expired_asset, 39
  field :untransferrable_asset, 40
  field :readonly_asset, 41
  field :consumed_asset, 42
  field :invalid_deposit_value, 43
  field :exceed_deposit_cap, 44
  field :invalid_deposit_target, 45
  field :invalid_depositor, 46
  field :invalid_withdrawer, 47
  field :invalid_expiry_date, 49
  field :invalid_deposit, 50
  field :invalid_custodian, 51
  field :insufficient_gas, 52
  field :invalid_swap, 53
  field :invalid_hashkey, 54
  field :invalid_delegation, 55
  field :insufficient_delegation, 56
  field :invalid_delegation_rule, 57
  field :invalid_delegation_type_url, 58
  field :sender_not_authorized, 59
  field :protocol_not_running, 60
  field :protocol_not_paused, 61
  field :protocol_not_activated, 62
  field :invalid_deactivation, 63
  field :sender_withdraw_items_full, 64
  field :withdraw_item_missing, 65
  field :invalid_withdraw_tx, 66
  field :invalid_chain_type, 67
  field :invalid_time, 68
  field :invalid_subscribe, 69
  field :invalid_did_type, 70
  field :invalid_candidate_state, 71
  field :validator_not_found, 72
  field :validator_not_changed, 73
  field :forbidden, 403
  field :internal, 500
  field :timeout, 504
end

defmodule ForgeAbi.KeyType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :ed25519 | :secp256k1

  field :ed25519, 0
  field :secp256k1, 1
end

defmodule ForgeAbi.HashType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :keccak | :sha3 | :sha2 | :keccak_384 | :sha3_384 | :keccak_512 | :sha3_512

  field :keccak, 0
  field :sha3, 1
  field :sha2, 2
  field :keccak_384, 6
  field :sha3_384, 7
  field :keccak_512, 13
  field :sha3_512, 14
end

defmodule ForgeAbi.EncodingType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :base16 | :base58

  field :base16, 0
  field :base58, 1
end

defmodule ForgeAbi.RoleType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t ::
          integer
          | :role_account
          | :role_node
          | :role_device
          | :role_application
          | :role_smart_contract
          | :role_bot
          | :role_asset
          | :role_stake
          | :role_validator
          | :role_group
          | :role_tx
          | :role_any

  field :role_account, 0
  field :role_node, 1
  field :role_device, 2
  field :role_application, 3
  field :role_smart_contract, 4
  field :role_bot, 5
  field :role_asset, 6
  field :role_stake, 7
  field :role_validator, 8
  field :role_group, 9
  field :role_tx, 10
  field :role_any, 63
end

defmodule ForgeAbi.UpgradeType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t ::
          integer
          | :config_app
          | :config_forge
          | :config_dfs
          | :config_consensus
          | :config_p2p
          | :exe_app
          | :exe_forge
          | :exe_dfs
          | :exe_consensus
          | :exe_p2p

  field :config_app, 0
  field :config_forge, 1
  field :config_dfs, 2
  field :config_consensus, 3
  field :config_p2p, 4
  field :exe_app, 10
  field :exe_forge, 11
  field :exe_dfs, 12
  field :exe_consensus, 13
  field :exe_p2p, 14
end

defmodule ForgeAbi.UpgradeAction do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t ::
          integer
          | :verify
          | :backup
          | :replace
          | :restart_app
          | :restart_dfs
          | :restart_consensus
          | :restart_p2p
          | :restart_forge
          | :rollback_if_fail
          | :restart_all_if_fail
          | :crash_if_fail
          | :drop_address_book

  field :verify, 0
  field :backup, 1
  field :replace, 2
  field :restart_app, 10
  field :restart_dfs, 11
  field :restart_consensus, 12
  field :restart_p2p, 13
  field :restart_forge, 14
  field :rollback_if_fail, 30
  field :restart_all_if_fail, 31
  field :crash_if_fail, 33
  field :drop_address_book, 50
end

defmodule ForgeAbi.StateType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t ::
          integer | :state_account | :state_asset | :state_channel | :state_forge | :state_stake

  field :state_account, 0
  field :state_asset, 1
  field :state_channel, 2
  field :state_forge, 3
  field :state_stake, 4
end

defmodule ForgeAbi.StakeType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :stake_node | :stake_user | :stake_asset | :stake_chain

  field :stake_node, 0
  field :stake_user, 1
  field :stake_asset, 2
  field :stake_chain, 3
end

defmodule ForgeAbi.ProtocolStatus do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :running | :paused | :terminated

  field :running, 0
  field :paused, 1
  field :terminated, 2
end
