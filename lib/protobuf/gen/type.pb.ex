defmodule ForgeAbi.BigUint do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: String.t()
        }
  defstruct [:value]

  field :value, 1, type: :bytes
end

defmodule ForgeAbi.BigSint do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: String.t(),
          minus: boolean
        }
  defstruct [:value, :minus]

  field :value, 1, type: :bytes
  field :minus, 2, type: :bool
end

defmodule ForgeAbi.WalletType do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pk: integer,
          hash: integer,
          address: integer,
          role: integer
        }
  defstruct [:pk, :hash, :address, :role]

  field :pk, 1, type: ForgeAbi.KeyType, enum: true
  field :hash, 2, type: ForgeAbi.HashType, enum: true
  field :address, 3, type: ForgeAbi.EncodingType, enum: true
  field :role, 4, type: ForgeAbi.RoleType, enum: true
end

defmodule ForgeAbi.WalletInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type: ForgeAbi.WalletType.t(),
          sk: String.t(),
          pk: String.t(),
          address: String.t()
        }
  defstruct [:type, :sk, :pk, :address]

  field :type, 1, type: ForgeAbi.WalletType
  field :sk, 2, type: :bytes
  field :pk, 3, type: :bytes
  field :address, 4, type: :string
end

defmodule ForgeAbi.ChainInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          network: String.t(),
          moniker: String.t(),
          consensus_version: String.t(),
          synced: boolean,
          app_hash: String.t(),
          block_hash: String.t(),
          block_height: non_neg_integer,
          block_time: Google.Protobuf.Timestamp.t(),
          address: String.t(),
          voting_power: non_neg_integer,
          total_txs: non_neg_integer,
          version: String.t(),
          data_version: String.t(),
          forge_apps_version: %{String.t() => String.t()},
          supported_txs: [String.t()]
        }
  defstruct [
    :id,
    :network,
    :moniker,
    :consensus_version,
    :synced,
    :app_hash,
    :block_hash,
    :block_height,
    :block_time,
    :address,
    :voting_power,
    :total_txs,
    :version,
    :data_version,
    :forge_apps_version,
    :supported_txs
  ]

  field :id, 1, type: :string
  field :network, 2, type: :string
  field :moniker, 3, type: :string
  field :consensus_version, 4, type: :string
  field :synced, 5, type: :bool
  field :app_hash, 6, type: :bytes
  field :block_hash, 7, type: :bytes
  field :block_height, 8, type: :uint64
  field :block_time, 9, type: Google.Protobuf.Timestamp
  field :address, 10, type: :string
  field :voting_power, 11, type: :uint64
  field :total_txs, 12, type: :uint64
  field :version, 13, type: :string
  field :data_version, 14, type: :string

  field :forge_apps_version, 15,
    repeated: true,
    type: ForgeAbi.ChainInfo.ForgeAppsVersionEntry,
    map: true

  field :supported_txs, 16, repeated: true, type: :string
end

defmodule ForgeAbi.ChainInfo.ForgeAppsVersionEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule ForgeAbi.NodeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          network: String.t(),
          moniker: String.t(),
          consensus_version: String.t(),
          synced: boolean,
          app_hash: String.t(),
          block_hash: String.t(),
          block_height: non_neg_integer,
          block_time: Google.Protobuf.Timestamp.t(),
          address: String.t(),
          voting_power: non_neg_integer,
          total_txs: non_neg_integer,
          version: String.t(),
          data_version: String.t(),
          forge_apps_version: %{String.t() => String.t()},
          supported_txs: [String.t()],
          ip: String.t(),
          geo_info: ForgeAbi.GeoInfo.t()
        }
  defstruct [
    :id,
    :network,
    :moniker,
    :consensus_version,
    :synced,
    :app_hash,
    :block_hash,
    :block_height,
    :block_time,
    :address,
    :voting_power,
    :total_txs,
    :version,
    :data_version,
    :forge_apps_version,
    :supported_txs,
    :ip,
    :geo_info
  ]

  field :id, 1, type: :string
  field :network, 2, type: :string
  field :moniker, 3, type: :string
  field :consensus_version, 4, type: :string
  field :synced, 5, type: :bool
  field :app_hash, 6, type: :bytes
  field :block_hash, 7, type: :bytes
  field :block_height, 8, type: :uint64
  field :block_time, 9, type: Google.Protobuf.Timestamp
  field :address, 10, type: :string
  field :voting_power, 11, type: :uint64
  field :total_txs, 12, type: :uint64
  field :version, 13, type: :string
  field :data_version, 14, type: :string

  field :forge_apps_version, 15,
    repeated: true,
    type: ForgeAbi.NodeInfo.ForgeAppsVersionEntry,
    map: true

  field :supported_txs, 16, repeated: true, type: :string
  field :ip, 17, type: :string
  field :geo_info, 18, type: ForgeAbi.GeoInfo
end

defmodule ForgeAbi.NodeInfo.ForgeAppsVersionEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule ForgeAbi.Validator do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          power: non_neg_integer
        }
  defstruct [:address, :power]

  field :address, 1, type: :string
  field :power, 2, type: :uint64
end

defmodule ForgeAbi.ConsensusParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          max_bytes: non_neg_integer,
          max_gas: integer,
          max_validators: non_neg_integer,
          max_candidates: non_neg_integer,
          pub_key_types: [String.t()],
          validators: [ForgeAbi.Validator.t()],
          validator_changed: boolean,
          param_changed: boolean
        }
  defstruct [
    :max_bytes,
    :max_gas,
    :max_validators,
    :max_candidates,
    :pub_key_types,
    :validators,
    :validator_changed,
    :param_changed
  ]

  field :max_bytes, 1, type: :uint64
  field :max_gas, 2, type: :sint64
  field :max_validators, 3, type: :uint32
  field :max_candidates, 4, type: :uint32
  field :pub_key_types, 5, repeated: true, type: :string
  field :validators, 6, repeated: true, type: ForgeAbi.Validator
  field :validator_changed, 7, type: :bool
  field :param_changed, 8, type: :bool
end

defmodule ForgeAbi.UpgradeTask do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type: integer,
          data_hash: String.t(),
          actions: [integer]
        }
  defstruct [:type, :data_hash, :actions]

  field :type, 1, type: ForgeAbi.UpgradeType, enum: true
  field :data_hash, 2, type: :string
  field :actions, 4, repeated: true, type: ForgeAbi.UpgradeAction, enum: true
end

defmodule ForgeAbi.UpgradeTasks do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          item: [ForgeAbi.UpgradeTask.t()]
        }
  defstruct [:item]

  field :item, 1, repeated: true, type: ForgeAbi.UpgradeTask
end

defmodule ForgeAbi.AbciContext do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx_hash: String.t(),
          block_height: non_neg_integer,
          block_time: Google.Protobuf.Timestamp.t(),
          total_txs: non_neg_integer,
          tx_statistics: ForgeAbi.TxStatistics.t(),
          tx_index: non_neg_integer,
          last_block_time: Google.Protobuf.Timestamp.t()
        }
  defstruct [
    :tx_hash,
    :block_height,
    :block_time,
    :total_txs,
    :tx_statistics,
    :tx_index,
    :last_block_time
  ]

  field :tx_hash, 1, type: :string
  field :block_height, 2, type: :uint64
  field :block_time, 3, type: Google.Protobuf.Timestamp
  field :total_txs, 4, type: :uint64
  field :tx_statistics, 5, type: ForgeAbi.TxStatistics
  field :tx_index, 6, type: :uint32
  field :last_block_time, 7, type: Google.Protobuf.Timestamp
end

defmodule ForgeAbi.Transaction do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          from: String.t(),
          nonce: non_neg_integer,
          signature: String.t(),
          chain_id: String.t(),
          signatures: [AbciVendor.KVPair.t()],
          itx: Google.Protobuf.Any.t()
        }
  defstruct [:from, :nonce, :signature, :chain_id, :signatures, :itx]

  field :from, 1, type: :string
  field :nonce, 2, type: :uint64
  field :signature, 3, type: :bytes
  field :chain_id, 4, type: :string
  field :signatures, 5, repeated: true, type: AbciVendor.KVPair
  field :itx, 7, type: Google.Protobuf.Any
end

defmodule ForgeAbi.TransactionInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: ForgeAbi.Transaction.t(),
          height: non_neg_integer,
          index: non_neg_integer,
          hash: String.t(),
          tags: [AbciVendor.KVPair.t()],
          code: integer
        }
  defstruct [:tx, :height, :index, :hash, :tags, :code]

  field :tx, 1, type: ForgeAbi.Transaction
  field :height, 2, type: :uint64
  field :index, 3, type: :uint32
  field :hash, 4, type: :string
  field :tags, 5, repeated: true, type: AbciVendor.KVPair
  field :code, 6, type: ForgeAbi.StatusCode, enum: true
end

defmodule ForgeAbi.BlockInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer,
          num_txs: non_neg_integer,
          time: Google.Protobuf.Timestamp.t(),
          app_hash: String.t(),
          proposer: String.t(),
          txs: [ForgeAbi.TransactionInfo.t()],
          total_txs: non_neg_integer
        }
  defstruct [:height, :num_txs, :time, :app_hash, :proposer, :txs, :total_txs]

  field :height, 1, type: :uint64
  field :num_txs, 2, type: :uint32
  field :time, 3, type: Google.Protobuf.Timestamp
  field :app_hash, 4, type: :string
  field :proposer, 5, type: :string
  field :txs, 6, repeated: true, type: ForgeAbi.TransactionInfo
  field :total_txs, 7, type: :uint64
end

defmodule ForgeAbi.TxStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          hash: String.t()
        }
  defstruct [:code, :hash]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :hash, 2, type: :string
end

defmodule ForgeAbi.CircularQueue do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          items: [String.t()],
          type_url: String.t(),
          max_items: non_neg_integer,
          circular: boolean,
          fifo: boolean
        }
  defstruct [:items, :type_url, :max_items, :circular, :fifo]

  field :items, 1, repeated: true, type: :bytes
  field :type_url, 2, type: :string
  field :max_items, 3, type: :uint32
  field :circular, 4, type: :bool
  field :fifo, 5, type: :bool
end

defmodule ForgeAbi.StateContext do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          genesis_tx: String.t(),
          renaissance_tx: String.t(),
          genesis_time: Google.Protobuf.Timestamp.t(),
          renaissance_time: Google.Protobuf.Timestamp.t()
        }
  defstruct [:genesis_tx, :renaissance_tx, :genesis_time, :renaissance_time]

  field :genesis_tx, 1, type: :string
  field :renaissance_tx, 2, type: :string
  field :genesis_time, 3, type: Google.Protobuf.Timestamp
  field :renaissance_time, 4, type: Google.Protobuf.Timestamp
end

defmodule ForgeAbi.StakeContext do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          total_stakes: ForgeAbi.BigUint.t(),
          total_unstakes: ForgeAbi.BigUint.t(),
          total_received_stakes: ForgeAbi.BigUint.t(),
          recent_stakes: ForgeAbi.CircularQueue.t(),
          recent_received_stakes: ForgeAbi.CircularQueue.t()
        }
  defstruct [
    :total_stakes,
    :total_unstakes,
    :total_received_stakes,
    :recent_stakes,
    :recent_received_stakes
  ]

  field :total_stakes, 1, type: ForgeAbi.BigUint
  field :total_unstakes, 2, type: ForgeAbi.BigUint
  field :total_received_stakes, 3, type: ForgeAbi.BigUint
  field :recent_stakes, 4, type: ForgeAbi.CircularQueue
  field :recent_received_stakes, 15, type: ForgeAbi.CircularQueue
end

defmodule ForgeAbi.StakeSummary do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          total_stakes: ForgeAbi.BigUint.t(),
          total_unstakes: ForgeAbi.BigUint.t(),
          context: ForgeAbi.StateContext.t()
        }
  defstruct [:total_stakes, :total_unstakes, :context]

  field :total_stakes, 1, type: ForgeAbi.BigUint
  field :total_unstakes, 2, type: ForgeAbi.BigUint
  field :context, 3, type: ForgeAbi.StateContext
end

defmodule ForgeAbi.UnconfirmedTxs do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          n_txs: non_neg_integer,
          txs: [ForgeAbi.Transaction.t()]
        }
  defstruct [:n_txs, :txs]

  field :n_txs, 1, type: :uint32
  field :txs, 2, repeated: true, type: ForgeAbi.Transaction
end

defmodule ForgeAbi.NetInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          listening: boolean,
          listeners: [String.t()],
          n_peers: non_neg_integer,
          peers: [ForgeAbi.PeerInfo.t()]
        }
  defstruct [:listening, :listeners, :n_peers, :peers]

  field :listening, 1, type: :bool
  field :listeners, 2, repeated: true, type: :string
  field :n_peers, 3, type: :uint32
  field :peers, 4, repeated: true, type: ForgeAbi.PeerInfo
end

defmodule ForgeAbi.GeoInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          city: String.t(),
          country: String.t(),
          latitude: float,
          longitude: float
        }
  defstruct [:city, :country, :latitude, :longitude]

  field :city, 1, type: :string
  field :country, 2, type: :string
  field :latitude, 3, type: :float
  field :longitude, 4, type: :float
end

defmodule ForgeAbi.PeerInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          network: String.t(),
          consensus_version: String.t(),
          moniker: String.t(),
          ip: String.t(),
          geo_info: ForgeAbi.GeoInfo.t()
        }
  defstruct [:id, :network, :consensus_version, :moniker, :ip, :geo_info]

  field :id, 1, type: :string
  field :network, 2, type: :string
  field :consensus_version, 3, type: :string
  field :moniker, 4, type: :string
  field :ip, 5, type: :string
  field :geo_info, 6, type: ForgeAbi.GeoInfo
end

defmodule ForgeAbi.ValidatorsInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_height: non_neg_integer,
          validators: [ForgeAbi.ValidatorInfo.t()]
        }
  defstruct [:block_height, :validators]

  field :block_height, 1, type: :uint64
  field :validators, 2, repeated: true, type: ForgeAbi.ValidatorInfo
end

defmodule ForgeAbi.ValidatorInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          pub_key: AbciVendor.PubKey.t(),
          voting_power: non_neg_integer,
          proposer_priority: String.t(),
          name: String.t()
        }
  defstruct [:address, :pub_key, :voting_power, :proposer_priority, :name]

  field :address, 1, type: :string
  field :pub_key, 2, type: AbciVendor.PubKey
  field :voting_power, 3, type: :uint64
  field :proposer_priority, 4, type: :string
  field :name, 5, type: :string
end

defmodule ForgeAbi.GenesisInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          genesis_time: String.t(),
          chain_id: String.t(),
          consensus_params: AbciVendor.ConsensusParams.t(),
          validators: [ForgeAbi.ValidatorInfo.t()],
          app_hash: String.t()
        }
  defstruct [:genesis_time, :chain_id, :consensus_params, :validators, :app_hash]

  field :genesis_time, 1, type: :string
  field :chain_id, 2, type: :string
  field :consensus_params, 3, type: AbciVendor.ConsensusParams
  field :validators, 4, repeated: true, type: ForgeAbi.ValidatorInfo
  field :app_hash, 5, type: :string
end

defmodule ForgeAbi.ForgeStatistics do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          num_blocks: [non_neg_integer],
          num_txs: [non_neg_integer],
          num_stakes: [ForgeAbi.BigUint.t()],
          num_validators: [non_neg_integer],
          num_account_migrate_txs: [non_neg_integer],
          num_create_asset_txs: [non_neg_integer],
          num_consensus_upgrade_txs: [non_neg_integer],
          num_declare_txs: [non_neg_integer],
          num_declare_file_txs: [non_neg_integer],
          num_exchange_txs: [non_neg_integer],
          num_stake_txs: [non_neg_integer],
          num_sys_upgrade_txs: [non_neg_integer],
          num_transfer_txs: [non_neg_integer],
          num_update_asset_txs: [non_neg_integer],
          num_activate_asset_txs: [non_neg_integer]
        }
  defstruct [
    :num_blocks,
    :num_txs,
    :num_stakes,
    :num_validators,
    :num_account_migrate_txs,
    :num_create_asset_txs,
    :num_consensus_upgrade_txs,
    :num_declare_txs,
    :num_declare_file_txs,
    :num_exchange_txs,
    :num_stake_txs,
    :num_sys_upgrade_txs,
    :num_transfer_txs,
    :num_update_asset_txs,
    :num_activate_asset_txs
  ]

  field :num_blocks, 1, repeated: true, type: :uint64
  field :num_txs, 2, repeated: true, type: :uint64
  field :num_stakes, 3, repeated: true, type: ForgeAbi.BigUint
  field :num_validators, 4, repeated: true, type: :uint32
  field :num_account_migrate_txs, 5, repeated: true, type: :uint64
  field :num_create_asset_txs, 6, repeated: true, type: :uint64
  field :num_consensus_upgrade_txs, 7, repeated: true, type: :uint32
  field :num_declare_txs, 8, repeated: true, type: :uint64
  field :num_declare_file_txs, 9, repeated: true, type: :uint64
  field :num_exchange_txs, 10, repeated: true, type: :uint64
  field :num_stake_txs, 11, repeated: true, type: :uint64
  field :num_sys_upgrade_txs, 12, repeated: true, type: :uint32
  field :num_transfer_txs, 13, repeated: true, type: :uint64
  field :num_update_asset_txs, 14, repeated: true, type: :uint64
  field :num_activate_asset_txs, 15, repeated: true, type: :uint64
end

defmodule ForgeAbi.TxStatistics do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          num_account_migrate_txs: non_neg_integer,
          num_create_asset_txs: non_neg_integer,
          num_consensus_upgrade_txs: non_neg_integer,
          num_declare_txs: non_neg_integer,
          num_declare_file_txs: non_neg_integer,
          num_exchange_txs: non_neg_integer,
          num_stake_txs: non_neg_integer,
          num_sys_upgrade_txs: non_neg_integer,
          num_transfer_txs: non_neg_integer,
          num_update_asset_txs: non_neg_integer,
          num_activate_asset_txs: non_neg_integer
        }
  defstruct [
    :num_account_migrate_txs,
    :num_create_asset_txs,
    :num_consensus_upgrade_txs,
    :num_declare_txs,
    :num_declare_file_txs,
    :num_exchange_txs,
    :num_stake_txs,
    :num_sys_upgrade_txs,
    :num_transfer_txs,
    :num_update_asset_txs,
    :num_activate_asset_txs
  ]

  field :num_account_migrate_txs, 1, type: :uint64
  field :num_create_asset_txs, 2, type: :uint64
  field :num_consensus_upgrade_txs, 3, type: :uint32
  field :num_declare_txs, 4, type: :uint64
  field :num_declare_file_txs, 5, type: :uint64
  field :num_exchange_txs, 6, type: :uint64
  field :num_stake_txs, 7, type: :uint64
  field :num_sys_upgrade_txs, 8, type: :uint32
  field :num_transfer_txs, 9, type: :uint64
  field :num_update_asset_txs, 10, type: :uint64
  field :num_activate_asset_txs, 11, type: :uint64
end
