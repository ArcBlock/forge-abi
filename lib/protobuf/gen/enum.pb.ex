defmodule ForgeAbi.StatusCode do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

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
  field :duplicate_tether, 48
  field :invalid_expiry_date, 49
  field :forbidden, 403
  field :internal, 500
  field :timeout, 504
end

defmodule ForgeAbi.TopicType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :transfer, 0
  field :exchange, 1
  field :declare, 2
  field :create_asset, 3
  field :update_asset, 4
  field :stake, 5
  field :account_migrate, 6
  field :begin_block, 16
  field :end_block, 17
  field :consensus_upgrade, 21
  field :declare_file, 22
  field :sys_upgrade, 23
  field :application, 24
  field :consume_asset, 25
  field :poke, 26
  field :account_state, 129
  field :asset_state, 130
  field :forge_state, 131
  field :stake_state, 132
  field :protocol_state, 133
end

defmodule ForgeAbi.KeyType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :ed25519, 0
  field :secp256k1, 1
end

defmodule ForgeAbi.HashType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

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

  field :base16, 0
  field :base58, 1
end

defmodule ForgeAbi.RoleType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

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
  field :role_tether, 11
  field :role_any, 63
end

defmodule ForgeAbi.UpgradeType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

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

  field :state_account, 0
  field :state_asset, 1
  field :state_channel, 2
  field :state_forge, 3
  field :state_stake, 4
end

defmodule ForgeAbi.StakeType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :stake_node, 0
  field :stake_user, 1
  field :stake_asset, 2
  field :stake_chain, 3
end

defmodule ForgeAbi.ProtocolStatus do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :running, 0
  field :paused, 1
  field :terminated, 2
end
