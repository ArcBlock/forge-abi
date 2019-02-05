defmodule ForgeWeb.GQL.Notation.Forge do
  @moduledoc "GraphQL Notation for forge"
  use(Absinthe.Schema.Notation)
  import_types(ForgeWeb.Type.Custom)
  alias(Absinthe.Resolution.Helpers)
  alias(Goldorin.Graphql.Resolver.Paging)
  alias(ForgeWeb.GQL.Forge.Resolver)
  alias(ForgeWeb.GQL.Forge.ResultResolver)

  @desc "OCAP adopts cursor-based pagination model. A cursor is a string value and serves like an anchor between two queries. The cursors are opaque which means their format should not be relied upon. We encode cursors in base64."
  object(:page_info) do
    field(:cursor, non_null(:string))
    field(:next, non_null(:boolean))
    field(:total, :integer)
  end

  @desc "When you carry out a query, in most of cases you can provide which field you want to us to order the result. The field to be ordered is vary query by query."
  input_object(:page_order) do
    field(:field, :string)
    field(:type, :string)
  end

  @desc "The common arguments for quering data with pagination."
  input_object(:page_input) do
    field(:cursor, :string)
    field(:order, list_of(:page_order))
    field(:size, :integer)
  end

  @desc ""
  enum(:status_code) do
    value(:internal, description: "", as: 500)
    value(:forbidden, description: "", as: 403)
    value(:invalid_tx_size, description: "", as: 36)
    value(:invalid_asset, description: "", as: 35)
    value(:banned_unstake, description: "", as: 34)
    value(:expired_wallet_token, description: "", as: 33)
    value(:invalid_stake_state, description: "", as: 32)
    value(:insufficient_stake, description: "", as: 31)
    value(:unsupported_stake, description: "", as: 30)
    value(:account_migrated, description: "", as: 27)
    value(:noent, description: "", as: 26)
    value(:storage_rpc_error, description: "", as: 25)
    value(:consensus_rpc_error, description: "", as: 24)
    value(:invalid_chain_id, description: "", as: 22)
    value(:invalid_wallet, description: "", as: 21)
    value(:invalid_multisig, description: "", as: 20)
    value(:invalid_channel_waiting_data, description: "", as: 19)
    value(:invalid_channel, description: "", as: 18)
    value(:invalid_passphrase, description: "", as: 17)
    value(:invalid_moniker, description: "", as: 16)
    value(:expired_tx, description: "", as: 10)
    value(:unsupported_tx, description: "", as: 9)
    value(:invalid_tx, description: "", as: 8)
    value(:invalid_owner, description: "", as: 7)
    value(:insufficient_fund, description: "", as: 6)
    value(:insufficient_data, description: "", as: 5)
    value(:invalid_receiver_state, description: "", as: 4)
    value(:invalid_sender_state, description: "", as: 3)
    value(:invalid_signature, description: "", as: 2)
    value(:invalid_nonce, description: "", as: 1)
    value(:ok, description: "", as: 0)
  end

  @desc ""
  enum(:topic_type) do
    value(:stake_state, description: "", as: 133)
    value(:forge_state, description: "", as: 132)
    value(:channel_state, description: "", as: 131)
    value(:asset_state, description: "", as: 130)
    value(:account_state, description: "", as: 129)
    value(:sys_upgrade, description: "", as: 23)
    value(:declare_file, description: "", as: 22)
    value(:consensus_upgrade, description: "", as: 21)
    value(:end_block, description: "", as: 17)
    value(:begin_block, description: "", as: 16)
    value(:account_migrate, description: "", as: 6)
    value(:stake, description: "", as: 5)
    value(:update_asset, description: "", as: 4)
    value(:create_asset, description: "", as: 3)
    value(:declare, description: "", as: 2)
    value(:exchange, description: "", as: 1)
    value(:transfer, description: "", as: 0)
  end

  @desc ""
  enum(:key_type) do
    value(:secp256k1, description: "", as: 1)
    value(:ed25519, description: "", as: 0)
  end

  @desc ""
  enum(:hash_type) do
    value(:sha3_512, description: "", as: 14)
    value(:keccak_512, description: "", as: 13)
    value(:sha3_384, description: "", as: 7)
    value(:keccak_384, description: "", as: 6)
    value(:sha3, description: "", as: 1)
    value(:keccak, description: "", as: 0)
  end

  @desc ""
  enum(:encoding_type) do
    value(:base58, description: "", as: 1)
    value(:base16, description: "", as: 0)
  end

  @desc ""
  enum(:role_type) do
    value(:role_validator, description: "", as: 8)
    value(:role_stake, description: "", as: 7)
    value(:role_asset, description: "", as: 6)
    value(:role_bot, description: "", as: 5)
    value(:role_smart_contract, description: "", as: 4)
    value(:role_application, description: "", as: 3)
    value(:role_device, description: "", as: 2)
    value(:role_node, description: "", as: 1)
    value(:role_account, description: "", as: 0)
  end

  @desc ""
  enum(:upgrade_type) do
    value(:exe_p2p, description: "", as: 14)
    value(:exe_consensus, description: "", as: 13)
    value(:exe_dfs, description: "", as: 12)
    value(:exe_forge, description: "", as: 11)
    value(:exe_app, description: "", as: 10)
    value(:config_p2p, description: "", as: 4)
    value(:config_consensus, description: "", as: 3)
    value(:config_dfs, description: "", as: 2)
    value(:config_forge, description: "", as: 1)
    value(:config_app, description: "", as: 0)
  end

  @desc ""
  enum(:upgrade_action) do
    value(:drop_address_book, description: "", as: 50)
    value(:crash_if_fail, description: "", as: 33)
    value(:restart_all_if_fail, description: "", as: 31)
    value(:rollback_if_fail, description: "", as: 30)
    value(:restart_forge, description: "", as: 14)
    value(:restart_p2p, description: "", as: 13)
    value(:restart_consensus, description: "", as: 12)
    value(:restart_dfs, description: "", as: 11)
    value(:restart_app, description: "", as: 10)
    value(:replace, description: "", as: 2)
    value(:backup, description: "", as: 1)
    value(:verify, description: "", as: 0)
  end

  @desc ""
  enum(:state_type) do
    value(:state_stake, description: "", as: 4)
    value(:state_forge, description: "", as: 3)
    value(:state_channel, description: "", as: 2)
    value(:state_asset, description: "", as: 1)
    value(:state_account, description: "", as: 0)
  end

  @desc ""
  enum(:stake_type) do
    value(:stake_chain, description: "", as: 3)
    value(:stake_asset, description: "", as: 2)
    value(:stake_user, description: "", as: 1)
    value(:stake_node, description: "", as: 0)
  end

  @desc "type url and value of any data"
  object(:any) do
    field(:type_url, non_null(:string))
    field(:value, non_null(:string))
  end

  @desc ""
  object(:kv_pair) do
    field(:key, :string)
    field(:value, :string)
  end

  @desc ""
  object(:proof_op) do
    field(:data, :string)
    field(:key, :string)
    field(:type, :string)
  end

  @desc ""
  object(:proof) do
    field(:ops, list_of(:proof_op))
  end

  @desc ""
  object(:block_size_params) do
    field(:max_bytes, :integer)
    field(:max_gas, :integer)
  end

  @desc ""
  object(:evidence_params) do
    field(:max_age, :integer)
  end

  @desc ""
  object(:validator_params) do
    field(:pub_key_types, list_of(:string))
  end

  @desc ""
  object(:consensus_params) do
    field(:block_size, :block_size_params)
    field(:evidence, :evidence_params)
    field(:validator, :validator_params)
  end

  @desc ""
  object(:last_commit_info) do
    field(:round, :integer)
    field(:votes, list_of(:vote_info))
  end

  @desc ""
  object(:version) do
    field(:App, :integer)
    field(:Block, :integer)
  end

  @desc ""
  object(:part_set_header) do
    field(:hash, :string)
    field(:total, :integer)
  end

  @desc ""
  object(:block_id) do
    field(:hash, :string)
    field(:parts_header, :part_set_header)
  end

  @desc ""
  object(:validator) do
    field(:address, :string)
    field(:power, :integer)
  end

  @desc ""
  object(:pub_key) do
    field(:data, :string)
    field(:type, :string)
  end

  @desc ""
  object(:validator_update) do
    field(:power, :integer)
    field(:pub_key, :pub_key)
  end

  @desc ""
  object(:vote_info) do
    field(:signed_last_block, :boolean)
    field(:validator, :validator)
  end

  @desc ""
  object(:evidence) do
    field(:height, :integer)
    field(:time, :datetime)
    field(:total_voting_power, :integer)
    field(:type, :string)
    field(:validator, :validator)
  end

  @desc ""
  object(:header) do
    field(:app_hash, :string)
    field(:chain_id, :string)
    field(:consensus_hash, :string)
    field(:data_hash, :string)
    field(:evidence_hash, :string)
    field(:height, :integer)
    field(:last_block_id, :block_id)
    field(:last_commit_hash, :string)
    field(:last_results_hash, :string)
    field(:next_validators_hash, :string)
    field(:num_txs, :integer)
    field(:proposer_address, :string)
    field(:time, :datetime)
    field(:total_txs, :integer)
    field(:validators_hash, :string)
    field(:version, :version)
  end

  @desc ""
  object(:request_echo) do
    field(:message, :string)
  end

  @desc ""
  object(:request_flush) do
  end

  @desc ""
  object(:request_info) do
    field(:block_version, :integer)
    field(:p2p_version, :integer)
    field(:version, :string)
  end

  @desc ""
  object(:request_set_option) do
    field(:key, :string)
    field(:value, :string)
  end

  @desc ""
  object(:request_init_chain) do
    field(:app_state_bytes, :string)
    field(:chain_id, :string)
    field(:consensus_params, :consensus_params)
    field(:time, :datetime)
    field(:validators, list_of(:validator_update))
  end

  @desc ""
  object(:request_query) do
    field(:data, :string)
    field(:height, :integer)
    field(:path, :string)
    field(:prove, :boolean)
  end

  @desc ""
  object(:request_begin_block) do
    field(:byzantine_validators, list_of(:evidence))
    field(:hash, :string)
    field(:header, :header)
    field(:last_commit_info, :last_commit_info)
  end

  @desc ""
  object(:request_check_tx) do
    field(:tx, :string)
  end

  @desc ""
  object(:request_deliver_tx) do
    field(:tx, :string)
  end

  @desc ""
  object(:request_end_block) do
    field(:height, :integer)
  end

  @desc ""
  object(:request_commit) do
  end

  @desc ""
  object(:request) do
    field(:begin_block, :request_begin_block)
    field(:check_tx, :request_check_tx)
    field(:commit, :request_commit)
    field(:deliver_tx, :request_deliver_tx)
    field(:echo, :request_echo)
    field(:end_block, :request_end_block)
    field(:flush, :request_flush)
    field(:info, :request_info)
    field(:init_chain, :request_init_chain)
    field(:query, :request_query)
    field(:set_option, :request_set_option)
  end

  @desc ""
  object(:response_exception) do
    field(:error, :string)
  end

  @desc ""
  object(:response_echo) do
    field(:message, :string)
  end

  @desc ""
  object(:response_flush) do
  end

  @desc ""
  object(:response_info) do
    field(:app_version, :integer)
    field(:data, :string)
    field(:last_block_app_hash, :string)
    field(:last_block_height, :integer)
    field(:version, :string)
  end

  @desc ""
  object(:response_set_option) do
    field(:code, :integer)
    field(:info, :string)
    field(:log, :string)
  end

  @desc ""
  object(:response_init_chain) do
    field(:consensus_params, :consensus_params)
    field(:validators, list_of(:validator_update))
  end

  @desc ""
  object(:response_query) do
    field(:code, :integer)
    field(:codespace, :string)
    field(:height, :integer)
    field(:index, :integer)
    field(:info, :string)
    field(:key, :string)
    field(:log, :string)
    field(:proof, :proof)
    field(:value, :string)
  end

  @desc ""
  object(:response_begin_block) do
    field(:tags, list_of(:kv_pair))
  end

  @desc ""
  object(:response_check_tx) do
    field(:code, :integer)
    field(:codespace, :string)
    field(:data, :string)
    field(:gas_used, :integer)
    field(:gas_wanted, :integer)
    field(:info, :string)
    field(:log, :string)
    field(:tags, list_of(:kv_pair))
  end

  @desc ""
  object(:response_deliver_tx) do
    field(:code, :integer)
    field(:codespace, :string)
    field(:data, :string)
    field(:gas_used, :integer)
    field(:gas_wanted, :integer)
    field(:info, :string)
    field(:log, :string)
    field(:tags, list_of(:kv_pair))
  end

  @desc ""
  object(:response_end_block) do
    field(:consensus_param_updates, :consensus_params)
    field(:tags, list_of(:kv_pair))
    field(:validator_updates, list_of(:validator_update))
  end

  @desc ""
  object(:response_commit) do
    field(:data, :string)
  end

  @desc ""
  object(:response) do
    field(:begin_block, :response_begin_block)
    field(:check_tx, :response_check_tx)
    field(:commit, :response_commit)
    field(:deliver_tx, :response_deliver_tx)
    field(:echo, :response_echo)
    field(:end_block, :response_end_block)
    field(:exception, :response_exception)
    field(:flush, :response_flush)
    field(:info, :response_info)
    field(:init_chain, :response_init_chain)
    field(:query, :response_query)
    field(:set_option, :response_set_option)
  end

  @desc ""
  object(:request_ping) do
  end

  @desc ""
  object(:request_broadcast_tx) do
    field(:tx, :string)
  end

  @desc ""
  object(:response_ping) do
  end

  @desc ""
  object(:response_broadcast_tx) do
    field(:check_tx, :response_check_tx)
    field(:deliver_tx, :response_deliver_tx)
  end

  @desc ""
  object(:big_uint) do
    field(:value, :string)
  end

  @desc ""
  object(:big_sint) do
    field(:minus, :boolean)
    field(:value, :string)
  end

  @desc ""
  object(:wallet_type) do
    field(:address, :encoding_type)
    field(:hash, :hash_type)
    field(:pk, :key_type)
    field(:role, :role_type)
  end

  @desc ""
  object(:wallet_info) do
    field(:address, :string)
    field(:pk, :string)
    field(:sk, :string)
    field(:type, :wallet_type)
  end

  @desc ""
  object(:chain_info) do
    field(:address, :string)
    field(:app_hash, :string)
    field(:block_hash, :string)
    field(:block_height, :integer)
    field(:block_time, :datetime)
    field(:consensus_version, :string)
    field(:data_version, :string)
    field(:forge_apps_version, list_of(:forge_apps_version_entry))
    field(:id, :string)
    field(:moniker, :string)
    field(:network, :string)
    field(:supported_txs, list_of(:string))
    field(:synced, :boolean)
    field(:total_txs, :integer)
    field(:version, :string)
    field(:voting_power, :integer)
  end

  @desc ""
  object(:forge_apps_version_entry) do
    field(:key, :string)
    field(:value, :string)
  end

  @desc ""
  object(:validator) do
    field(:address, :string)
    field(:power, :integer)
  end

  @desc ""
  object(:consensus_params) do
    field(:max_bytes, :integer)
    field(:max_candidates, :integer)
    field(:max_gas, :integer)
    field(:max_validators, :integer)
    field(:param_changed, :boolean)
    field(:pub_key_types, list_of(:string))
    field(:validator_changed, :boolean)
    field(:validators, list_of(:validator))
  end

  @desc ""
  object(:upgrade_task) do
    field(:actions, list_of(:upgrade_action))
    field(:data_hash, :string)
    field(:type, :upgrade_type)
  end

  @desc ""
  object(:upgrade_tasks) do
    field(:item, list_of(:upgrade_task))
  end

  @desc ""
  object(:abci_context) do
    field(:block_height, :integer)
    field(:block_time, :datetime)
    field(:tx_hash, :string)
  end

  @desc ""
  object(:transaction) do
    field(:chain_id, :string)
    field(:from, :string)
    field(:itx, :any)
    field(:nonce, :integer)
    field(:signature, :string)
    field(:signatures, list_of(:kv_pair))
  end

  @desc ""
  object(:transaction_info) do
    field(:hash, :string)
    field(:height, :integer)
    field(:index, :integer)
    field(:tags, list_of(:kv_pair))
    field(:tx, :transaction)
  end

  @desc ""
  object(:block_info) do
    field(:app_hash, :string)
    field(:height, :integer)
    field(:num_txs, :integer)
    field(:proposer, :string)
    field(:time, :datetime)
    field(:total_txs, :integer)
    field(:txs, list_of(:transaction))
  end

  @desc ""
  object(:tx_status) do
    field(:code, :status_code)
    field(:hash, :string)
  end

  @desc ""
  object(:circular_queue) do
    field(:circular, :boolean)
    field(:fifo, :boolean)
    field(:items, list_of(:string))
    field(:max_items, :integer)
    field(:type_url, :string)
  end

  @desc ""
  object(:state_context) do
    field(:genesis_time, :datetime)
    field(:genesis_tx, :string)
    field(:renaissance_time, :datetime)
    field(:renaissance_tx, :string)
  end

  @desc ""
  object(:stake_context) do
    field(:recent_received_stakes, :circular_queue)
    field(:recent_stakes, :circular_queue)
    field(:total_received_stakes, :string)
    field(:total_stakes, :string)
    field(:total_unstakes, :string)
  end

  @desc ""
  object(:stake_summary) do
    field(:context, :state_context)
    field(:total_stakes, :string)
    field(:total_unstakes, :string)
  end

  @desc ""
  object(:unconfirmed_txs) do
    field(:n_txs, :integer)
    field(:txs, list_of(:transaction))
  end

  @desc ""
  object(:net_info) do
    field(:listeners, list_of(:string))
    field(:listening, :boolean)
    field(:n_peers, :integer)
    field(:peers, list_of(:peer_info))
  end

  @desc ""
  object(:peer_info) do
    field(:node_info, :node_info)
  end

  @desc ""
  object(:node_info) do
    field(:geo_info, :geo_info)
    field(:id, :string)
    field(:ip, :string)
    field(:moniker, :string)
    field(:network, :string)
    field(:version, :string)
  end

  @desc ""
  object(:geo_info) do
    field(:city, :string)
    field(:country, :string)
    field(:latitude, :float)
    field(:longitude, :float)
  end

  @desc ""
  object(:validators_info) do
    field(:block_height, :integer)
    field(:validators, list_of(:validator_info))
  end

  @desc ""
  object(:validator_info) do
    field(:address, :string)
    field(:name, :string)
    field(:proposer_priority, :string)
    field(:pub_key, :pub_key)
    field(:voting_power, :integer)
  end

  @desc ""
  object(:genesis_info) do
    field(:app_hash, :string)
    field(:chain_id, :string)
    field(:consensus_params, :consensus_params)
    field(:genesis_time, :string)
    field(:validators, list_of(:validator_info))
  end

  @desc ""
  object(:state_context) do
    field(:genesis_time, :datetime)
    field(:genesis_tx, :transaction_info)
    field(:renaissance_time, :datetime)
    field(:renaissance_tx, :transaction_info)
  end

  @desc ""
  object(:account_state) do
    field(:address, :string)
    field(:balance, :string)
    field(:context, :state_context)
    field(:data, :any)
    field(:migrated_from, list_of(:string))
    field(:migrated_to, list_of(:string))
    field(:moniker, :string)
    field(:nonce, :integer)
    field(:num_assets, :integer)
    field(:num_txs, :integer)
    field(:pinned_files, :circular_queue)
    field(:pk, :string)
    field(:stake, :stake_context)
    field(:type, :wallet_type)
  end

  @desc ""
  object(:asset_state) do
    field(:address, :string)
    field(:context, :state_context)
    field(:data, :any)
    field(:moniker, :string)
    field(:owner, :string)
    field(:readonly, :boolean)
    field(:stake, :stake_context)
  end

  @desc ""
  object(:forge_state) do
    field(:consensus, :consensus_params)
    field(:data, :any)
    field(:data_version, :string)
    field(:stake_summary, list_of(:stake_summary_entry))
    field(:tasks, list_of(:tasks_entry))
    field(:version, :string)
  end

  @desc ""
  object(:tasks_entry) do
    field(:key, :integer)
    field(:value, :upgrade_tasks)
  end

  @desc ""
  object(:stake_summary_entry) do
    field(:key, :integer)
    field(:value, :stake_summary)
  end

  @desc ""
  object(:stake_state) do
    field(:address, :string)
    field(:balance, :string)
    field(:context, :state_context)
    field(:data, :any)
    field(:from, :string)
    field(:message, :string)
    field(:to, :string)
  end

  @desc ""
  object(:account_migrate_tx) do
    field(:pk, :string)
    field(:type, :wallet_type)
  end

  @desc ""
  object(:consensus_upgrade_tx) do
    field(:validators, list_of(:validator))
  end

  @desc ""
  object(:create_asset_tx) do
    field(:data, :any)
    field(:moniker, :string)
    field(:readonly, :boolean)
  end

  @desc ""
  object(:declare_tx) do
    field(:moniker, :string)
    field(:pk, :string)
    field(:type, :wallet_type)
  end

  @desc ""
  object(:declare_file_tx) do
    field(:hash, :string)
  end

  @desc ""
  object(:exchange_info) do
    field(:assets, list_of(:string))
    field(:value, :string)
  end

  @desc ""
  object(:exchange_tx) do
    field(:expired_at, :datetime)
    field(:receiver, :exchange_info)
    field(:sender, :exchange_info)
    field(:to, :string)
  end

  @desc ""
  object(:stake_for_asset) do
  end

  @desc ""
  object(:stake_for_chain) do
  end

  @desc ""
  object(:stake_for_node) do
  end

  @desc ""
  object(:stake_for_user) do
  end

  @desc ""
  object(:stake_tx) do
    field(:data, :any)
    field(:message, :string)
    field(:to, :string)
    field(:value, :string)
  end

  @desc ""
  object(:sys_upgrade_tx) do
    field(:grace_period, :integer)
    field(:task, :upgrade_task)
  end

  @desc ""
  object(:transfer_tx) do
    field(:assets, list_of(:string))
    field(:to, :string)
    field(:value, :string)
  end

  @desc ""
  object(:update_asset_tx) do
    field(:address, :string)
    field(:data, :any)
    field(:moniker, :string)
  end

  @desc "stake type"
  object(:stake_data_type) do
    field(:type, :string)
  end

  @desc "stake tx"
  object(:stake_tx) do
    field(:data, :stake_data_type)
    field(:message, :string)
    field(:to, :string)
    field(:value, :string)
  end

  @desc "inner transaction"
  union(:itx) do
    types([
      :update_asset_tx,
      :transfer_tx,
      :sys_upgrade_tx,
      :stake_tx,
      :exchange_tx,
      :declare_file_tx,
      :declare_tx,
      :create_asset_tx,
      :consensus_upgrade_tx,
      :account_migrate_tx
    ])

    resolve_type(fn obj, env -> apply(Resolver, :get_itx_type, [obj, env]) end)
  end

  @desc "transaction details"
  object(:transaction) do
    field(:chain_id, non_null(:integer))
    field(:from, non_null(:string))
    field(:itx, non_null(:itx))
    field(:nonce, non_null(:integer))
    field(:signature, :string)
    field(:signatures, list_of(:kv_pair))
  end

  @desc ""
  input_object(:request_create_tx) do
    field(:from, :string)
    field(:itx, :any)
    field(:nonce, :integer)
    field(:token, :string)
    field(:wallet, :wallet_info)
  end

  @desc ""
  object(:response_create_tx) do
    field(:code, :status_code)
    field(:tx, :transaction)
  end

  @desc ""
  input_object(:request_multisig) do
    field(:token, :string)
    field(:tx, :transaction)
    field(:wallet, :wallet_info)
  end

  @desc ""
  object(:response_multisig) do
    field(:code, :status_code)
    field(:tx, :transaction)
  end

  @desc ""
  input_object(:request_send_tx) do
    field(:commit, :boolean)
    field(:token, :string)
    field(:tx, :transaction)
    field(:wallet, :wallet_info)
  end

  @desc ""
  object(:response_send_tx) do
    field(:code, :status_code)
    field(:hash, :string)
  end

  @desc ""
  input_object(:request_get_tx) do
    field(:hash, :string)
  end

  @desc ""
  object(:response_get_tx) do
    field(:code, :status_code)
    field(:info, :transaction_info)
  end

  @desc ""
  input_object(:request_get_block) do
    field(:height, :integer)
  end

  @desc ""
  object(:response_get_block) do
    field(:block, :block_info)
    field(:code, :status_code)
  end

  @desc ""
  input_object(:request_get_blocks) do
    field(:max_height, :integer)
    field(:min_height, :integer)
  end

  @desc ""
  object(:response_get_blocks) do
    field(:blocks, list_of(:block_info))
    field(:code, :status_code)
  end

  @desc ""
  input_object(:request_create_wallet) do
    field(:moniker, :string)
    field(:passphrase, :string)
    field(:type, :wallet_type)
  end

  @desc ""
  object(:response_create_wallet) do
    field(:code, :status_code)
    field(:token, :string)
    field(:wallet, :wallet_info)
  end

  @desc ""
  input_object(:request_load_wallet) do
    field(:address, :string)
    field(:passphrase, :string)
  end

  @desc ""
  object(:response_load_wallet) do
    field(:code, :status_code)
    field(:token, :string)
    field(:wallet, :wallet_info)
  end

  @desc ""
  input_object(:request_recover_wallet) do
    field(:data, :string)
    field(:moniker, :string)
    field(:passphrase, :string)
    field(:type, :wallet_type)
  end

  @desc ""
  object(:response_recover_wallet) do
    field(:code, :status_code)
    field(:token, :string)
    field(:wallet, :wallet_info)
  end

  @desc ""
  input_object(:request_list_wallet) do
  end

  @desc ""
  object(:response_list_wallet) do
    field(:address, :string)
    field(:code, :status_code)
  end

  @desc ""
  input_object(:request_remove_wallet) do
    field(:address, :string)
  end

  @desc ""
  object(:response_remove_wallet) do
    field(:code, :status_code)
  end

  @desc ""
  input_object(:request_declare_node) do
    field(:validator, :boolean)
  end

  @desc ""
  object(:response_declare_node) do
    field(:code, :status_code)
    field(:wallet, :wallet_info)
  end

  @desc ""
  input_object(:request_get_account_state) do
    field(:address, :string)
    field(:app_hash, :string)
    field(:keys, list_of(:string))
  end

  @desc ""
  object(:response_get_account_state) do
    field(:code, :status_code)
    field(:state, :account_state)
  end

  @desc ""
  input_object(:request_get_asset_state) do
    field(:address, :string)
    field(:app_hash, :string)
    field(:keys, list_of(:string))
  end

  @desc ""
  object(:response_get_asset_state) do
    field(:code, :status_code)
    field(:state, :asset_state)
  end

  @desc ""
  input_object(:request_get_stake_state) do
    field(:address, :string)
    field(:app_hash, :string)
    field(:keys, list_of(:string))
  end

  @desc ""
  object(:response_get_stake_state) do
    field(:code, :status_code)
    field(:state, :stake_state)
  end

  @desc ""
  input_object(:request_get_forge_state) do
    field(:app_hash, :string)
    field(:keys, list_of(:string))
  end

  @desc ""
  object(:response_get_forge_state) do
    field(:code, :status_code)
    field(:state, :forge_state)
  end

  @desc ""
  input_object(:request_store_file) do
    field(:chunk, :string)
  end

  @desc ""
  object(:response_store_file) do
    field(:code, :status_code)
    field(:hash, :string)
  end

  @desc ""
  input_object(:request_load_file) do
    field(:hash, :string)
  end

  @desc ""
  object(:response_load_file) do
    field(:chunk, :string)
    field(:code, :status_code)
  end

  @desc ""
  input_object(:request_pin_file) do
    field(:hash, :string)
  end

  @desc ""
  object(:response_pin_file) do
    field(:code, :status_code)
  end

  @desc ""
  input_object(:request_get_chain_info) do
  end

  @desc ""
  object(:response_get_chain_info) do
    field(:code, :status_code)
    field(:info, :chain_info)
  end

  @desc ""
  input_object(:request_search) do
    field(:key, :string)
    field(:value, :string)
  end

  @desc ""
  object(:response_search) do
    field(:code, :status_code)
    field(:txs, list_of(:transaction_info))
  end

  @desc ""
  input_object(:request_get_unconfirmed_txs) do
    field(:limit, :integer)
  end

  @desc ""
  object(:response_get_unconfirmed_txs) do
    field(:code, :status_code)
    field(:unconfirmed_txs, :unconfirmed_txs)
  end

  @desc ""
  input_object(:request_get_net_info) do
  end

  @desc ""
  object(:response_get_net_info) do
    field(:code, :status_code)
    field(:net_info, :net_info)
  end

  @desc ""
  input_object(:request_get_validators_info) do
  end

  @desc ""
  object(:response_get_validators_info) do
    field(:code, :status_code)
    field(:validators_info, :validators_info)
  end

  @desc ""
  input_object(:request_subscribe) do
    field(:filter, :string)
    field(:type, :topic_type)
  end

  @desc ""
  object(:response_subscribe) do
    field(:account_migrate, :transaction)
    field(:account_state, :transaction)
    field(:asset_state, :transaction)
    field(:begin_block, :request_begin_block)
    field(:code, :status_code)
    field(:confirm, :transaction)
    field(:consensus_upgrade, :transaction)
    field(:create_asset, :transaction)
    field(:declare, :transaction)
    field(:declare_file, :transaction)
    field(:end_block, :request_end_block)
    field(:exchange, :transaction)
    field(:forge_state, :transaction)
    field(:revoke, :transaction)
    field(:stake, :transaction)
    field(:stake_state, :transaction)
    field(:sys_upgrade, :transaction)
    field(:topic, :string)
    field(:transfer, :transaction)
    field(:update_asset, :transaction)
  end

  @desc ""
  input_object(:request_unsubscribe) do
    field(:topic, :string)
  end

  @desc ""
  object(:response_unsubscribe) do
    field(:code, :status_code)
  end

  @desc ""
  input_object(:request_get_config) do
  end

  @desc ""
  object(:response_get_config) do
    field(:code, :status_code)
    field(:config, :string)
  end

  @desc ""
  object(:response_list_wallet) do
    field(:address, list_of(:string))
    field(:code, :status_code)
  end
end
