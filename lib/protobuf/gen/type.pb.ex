defmodule ForgeAbi.BigUint do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: binary
        }
  defstruct [:value]

  field :value, 1, type: :bytes
end

defmodule ForgeAbi.BigSint do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: binary,
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
          pk: atom | integer,
          hash: atom | integer,
          address: atom | integer,
          role: atom | integer
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
          type: ForgeAbi.WalletType.t() | nil,
          sk: binary,
          pk: binary,
          address: String.t()
        }
  defstruct [:type, :sk, :pk, :address]

  field :type, 1, type: ForgeAbi.WalletType, deprecated: true
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
          app_hash: binary,
          block_hash: binary,
          block_height: non_neg_integer,
          block_time: Google.Protobuf.Timestamp.t() | nil,
          address: String.t(),
          voting_power: non_neg_integer,
          total_txs: non_neg_integer,
          version: String.t(),
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
          app_hash: binary,
          block_hash: binary,
          block_height: non_neg_integer,
          block_time: Google.Protobuf.Timestamp.t() | nil,
          address: String.t(),
          voting_power: non_neg_integer,
          total_txs: non_neg_integer,
          version: String.t(),
          forge_apps_version: %{String.t() => String.t()},
          supported_txs: [String.t()],
          ip: String.t(),
          geo_info: ForgeAbi.GeoInfo.t() | nil,
          p2p_address: String.t()
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
    :forge_apps_version,
    :supported_txs,
    :ip,
    :geo_info,
    :p2p_address
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

  field :forge_apps_version, 15,
    repeated: true,
    type: ForgeAbi.NodeInfo.ForgeAppsVersionEntry,
    map: true

  field :supported_txs, 16, repeated: true, type: :string
  field :ip, 17, type: :string
  field :geo_info, 18, type: ForgeAbi.GeoInfo
  field :p2p_address, 19, type: :string
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
          type: atom | integer,
          data_hash: String.t(),
          actions: [atom | integer]
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
          block_time: Google.Protobuf.Timestamp.t() | nil,
          total_txs: non_neg_integer,
          tx_statistics: ForgeAbi.TxStatistics.t() | nil,
          tx_index: non_neg_integer,
          last_block_time: Google.Protobuf.Timestamp.t() | nil
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

defmodule ForgeAbi.Multisig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          signer: String.t(),
          pk: binary,
          signature: binary,
          delegator: String.t(),
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:signer, :pk, :signature, :delegator, :data]

  field :signer, 1, type: :string
  field :pk, 2, type: :bytes
  field :signature, 3, type: :bytes
  field :delegator, 4, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.Transaction do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          from: String.t(),
          nonce: non_neg_integer,
          chain_id: String.t(),
          pk: binary,
          gas: non_neg_integer,
          delegator: String.t(),
          signature: binary,
          signatures: [ForgeAbi.Multisig.t()],
          itx: Google.Protobuf.Any.t() | nil
        }
  defstruct [:from, :nonce, :chain_id, :pk, :gas, :delegator, :signature, :signatures, :itx]

  field :from, 1, type: :string
  field :nonce, 2, type: :uint64
  field :chain_id, 3, type: :string
  field :pk, 4, type: :bytes
  field :gas, 5, type: :uint32
  field :delegator, 6, type: :string
  field :signature, 13, type: :bytes
  field :signatures, 14, repeated: true, type: ForgeAbi.Multisig
  field :itx, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.TransactionInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: ForgeAbi.Transaction.t() | nil,
          height: non_neg_integer,
          index: non_neg_integer,
          hash: String.t(),
          tags: [AbciVendor.KVPair.t()],
          code: atom | integer,
          time: Google.Protobuf.Timestamp.t() | nil
        }
  defstruct [:tx, :height, :index, :hash, :tags, :code, :time]

  field :tx, 1, type: ForgeAbi.Transaction
  field :height, 2, type: :uint64
  field :index, 3, type: :uint32
  field :hash, 4, type: :string
  field :tags, 5, repeated: true, type: AbciVendor.KVPair
  field :code, 6, type: ForgeAbi.StatusCode, enum: true
  field :time, 7, type: Google.Protobuf.Timestamp
end

defmodule ForgeAbi.DeclareConfig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          restricted: boolean,
          hierarchy: non_neg_integer
        }
  defstruct [:restricted, :hierarchy]

  field :restricted, 1, type: :bool
  field :hierarchy, 2, type: :uint32
end

defmodule ForgeAbi.DelegateConfig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          delta_interval: non_neg_integer,
          type_urls: [String.t()]
        }
  defstruct [:delta_interval, :type_urls]

  field :delta_interval, 1, type: :uint32
  field :type_urls, 2, repeated: true, type: :string
end

defmodule ForgeAbi.TransactionConfig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          max_asset_size: non_neg_integer,
          max_list_size: non_neg_integer,
          max_multisig: non_neg_integer,
          minimum_stake: non_neg_integer,
          declare: ForgeAbi.DeclareConfig.t() | nil,
          delegate: ForgeAbi.DelegateConfig.t() | nil
        }
  defstruct [:max_asset_size, :max_list_size, :max_multisig, :minimum_stake, :declare, :delegate]

  field :max_asset_size, 1, type: :uint32
  field :max_list_size, 2, type: :uint32
  field :max_multisig, 3, type: :uint32
  field :minimum_stake, 4, type: :uint64
  field :declare, 5, type: ForgeAbi.DeclareConfig
  field :delegate, 6, type: ForgeAbi.DelegateConfig
end

defmodule ForgeAbi.BlockInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer,
          num_txs: non_neg_integer,
          time: Google.Protobuf.Timestamp.t() | nil,
          app_hash: binary,
          proposer: binary,
          txs: [ForgeAbi.TransactionInfo.t()],
          total_txs: non_neg_integer,
          invalid_txs: [ForgeAbi.TransactionInfo.t()],
          txs_hashes: [String.t()],
          invalid_txs_hashes: [String.t()],
          consensus_hash: binary,
          data_hash: binary,
          evidence_hash: binary,
          last_commit_hash: binary,
          last_results_hash: binary,
          next_validators_hash: binary,
          validators_hash: binary,
          version: AbciVendor.Version.t() | nil,
          last_block_id: AbciVendor.BlockID.t() | nil
        }
  defstruct [
    :height,
    :num_txs,
    :time,
    :app_hash,
    :proposer,
    :txs,
    :total_txs,
    :invalid_txs,
    :txs_hashes,
    :invalid_txs_hashes,
    :consensus_hash,
    :data_hash,
    :evidence_hash,
    :last_commit_hash,
    :last_results_hash,
    :next_validators_hash,
    :validators_hash,
    :version,
    :last_block_id
  ]

  field :height, 1, type: :uint64
  field :num_txs, 2, type: :uint32
  field :time, 3, type: Google.Protobuf.Timestamp
  field :app_hash, 4, type: :bytes
  field :proposer, 5, type: :bytes
  field :txs, 6, repeated: true, type: ForgeAbi.TransactionInfo
  field :total_txs, 7, type: :uint64
  field :invalid_txs, 8, repeated: true, type: ForgeAbi.TransactionInfo
  field :txs_hashes, 9, repeated: true, type: :string
  field :invalid_txs_hashes, 10, repeated: true, type: :string
  field :consensus_hash, 11, type: :bytes
  field :data_hash, 12, type: :bytes
  field :evidence_hash, 13, type: :bytes
  field :last_commit_hash, 14, type: :bytes
  field :last_results_hash, 15, type: :bytes
  field :next_validators_hash, 16, type: :bytes
  field :validators_hash, 17, type: :bytes
  field :version, 18, type: AbciVendor.Version
  field :last_block_id, 19, type: AbciVendor.BlockID
end

defmodule ForgeAbi.BlockInfoSimple do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer,
          num_txs: non_neg_integer,
          time: Google.Protobuf.Timestamp.t() | nil,
          app_hash: binary,
          proposer: binary,
          total_txs: non_neg_integer,
          txs_hashes: [String.t()],
          invalid_txs_hashes: [String.t()],
          consensus_hash: binary,
          data_hash: binary,
          evidence_hash: binary,
          last_commit_hash: binary,
          last_results_hash: binary,
          next_validators_hash: binary,
          validators_hash: binary,
          version: AbciVendor.Version.t() | nil,
          last_block_id: AbciVendor.BlockID.t() | nil
        }
  defstruct [
    :height,
    :num_txs,
    :time,
    :app_hash,
    :proposer,
    :total_txs,
    :txs_hashes,
    :invalid_txs_hashes,
    :consensus_hash,
    :data_hash,
    :evidence_hash,
    :last_commit_hash,
    :last_results_hash,
    :next_validators_hash,
    :validators_hash,
    :version,
    :last_block_id
  ]

  field :height, 1, type: :uint64
  field :num_txs, 2, type: :uint32
  field :time, 3, type: Google.Protobuf.Timestamp
  field :app_hash, 4, type: :bytes
  field :proposer, 5, type: :bytes
  field :total_txs, 6, type: :uint64
  field :txs_hashes, 7, repeated: true, type: :string
  field :invalid_txs_hashes, 8, repeated: true, type: :string
  field :consensus_hash, 9, type: :bytes
  field :data_hash, 10, type: :bytes
  field :evidence_hash, 11, type: :bytes
  field :last_commit_hash, 12, type: :bytes
  field :last_results_hash, 13, type: :bytes
  field :next_validators_hash, 14, type: :bytes
  field :validators_hash, 15, type: :bytes
  field :version, 16, type: AbciVendor.Version
  field :last_block_id, 17, type: AbciVendor.BlockID
end

defmodule ForgeAbi.TxStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: atom | integer,
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
          items: [binary],
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
          genesis_time: Google.Protobuf.Timestamp.t() | nil,
          renaissance_time: Google.Protobuf.Timestamp.t() | nil
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
          total_stakes: ForgeAbi.BigUint.t() | nil,
          total_unstakes: ForgeAbi.BigUint.t() | nil,
          total_received_stakes: ForgeAbi.BigUint.t() | nil,
          recent_stakes: ForgeAbi.CircularQueue.t() | nil,
          recent_received_stakes: ForgeAbi.CircularQueue.t() | nil
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
          total_stakes: ForgeAbi.BigUint.t() | nil,
          total_unstakes: ForgeAbi.BigUint.t() | nil,
          context: ForgeAbi.StateContext.t() | nil
        }
  defstruct [:total_stakes, :total_unstakes, :context]

  field :total_stakes, 1, type: ForgeAbi.BigUint
  field :total_unstakes, 2, type: ForgeAbi.BigUint
  field :context, 3, type: ForgeAbi.StateContext
end

defmodule ForgeAbi.StakeConfig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          timeout_general: non_neg_integer,
          timeout_stake_for_node: non_neg_integer
        }
  defstruct [:timeout_general, :timeout_stake_for_node]

  field :timeout_general, 1, type: :uint32
  field :timeout_stake_for_node, 2, type: :uint32
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
          geo_info: ForgeAbi.GeoInfo.t() | nil
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
          pub_key: AbciVendor.PubKey.t() | nil,
          voting_power: non_neg_integer,
          proposer_priority: String.t(),
          name: String.t(),
          geo_info: ForgeAbi.GeoInfo.t() | nil
        }
  defstruct [:address, :pub_key, :voting_power, :proposer_priority, :name, :geo_info]

  field :address, 1, type: :string
  field :pub_key, 2, type: AbciVendor.PubKey
  field :voting_power, 3, type: :uint64
  field :proposer_priority, 4, type: :string
  field :name, 5, type: :string
  field :geo_info, 6, type: ForgeAbi.GeoInfo
end

defmodule ForgeAbi.GenesisInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          genesis_time: String.t(),
          chain_id: String.t(),
          consensus_params: AbciVendor.ConsensusParams.t() | nil,
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

defmodule ForgeAbi.ForgeStats do
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
          num_consume_asset_txs: [non_neg_integer],
          num_poke_txs: [non_neg_integer],
          tps: [non_neg_integer],
          max_tps: non_neg_integer,
          avg_tps: non_neg_integer,
          avg_block_time: float
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
    :num_consume_asset_txs,
    :num_poke_txs,
    :tps,
    :max_tps,
    :avg_tps,
    :avg_block_time
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
  field :num_consume_asset_txs, 15, repeated: true, type: :uint64
  field :num_poke_txs, 16, repeated: true, type: :uint64
  field :tps, 17, repeated: true, type: :uint32
  field :max_tps, 18, type: :uint32
  field :avg_tps, 19, type: :uint32
  field :avg_block_time, 20, type: :float
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
          num_consume_asset_txs: non_neg_integer,
          num_poke_txs: non_neg_integer
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
    :num_consume_asset_txs,
    :num_poke_txs
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
  field :num_consume_asset_txs, 11, type: :uint64
  field :num_poke_txs, 12, type: :uint64
end

defmodule ForgeAbi.ForgeToken do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          symbol: String.t(),
          unit: String.t(),
          description: String.t(),
          icon: binary,
          decimal: non_neg_integer,
          initial_supply: non_neg_integer,
          total_supply: non_neg_integer,
          inflation_rate: non_neg_integer
        }
  defstruct [
    :name,
    :symbol,
    :unit,
    :description,
    :icon,
    :decimal,
    :initial_supply,
    :total_supply,
    :inflation_rate
  ]

  field :name, 1, type: :string
  field :symbol, 2, type: :string
  field :unit, 3, type: :string
  field :description, 4, type: :string
  field :icon, 5, type: :bytes
  field :decimal, 6, type: :uint32
  field :initial_supply, 7, type: :uint64
  field :total_supply, 8, type: :uint64
  field :inflation_rate, 9, type: :uint32
end

defmodule ForgeAbi.PokeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          daily_limit: ForgeAbi.BigUint.t() | nil,
          leftover: ForgeAbi.BigUint.t() | nil,
          amount: ForgeAbi.BigUint.t() | nil
        }
  defstruct [:daily_limit, :leftover, :amount]

  field :daily_limit, 1, type: ForgeAbi.BigUint
  field :leftover, 2, type: ForgeAbi.BigUint
  field :amount, 3, type: ForgeAbi.BigUint
end

defmodule ForgeAbi.PokeConfig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          daily_limit: non_neg_integer,
          balance: non_neg_integer,
          amount: non_neg_integer
        }
  defstruct [:address, :daily_limit, :balance, :amount]

  field :address, 1, type: :string
  field :daily_limit, 2, type: :uint64
  field :balance, 3, type: :uint64
  field :amount, 4, type: :uint64
end

defmodule ForgeAbi.UpgradeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer,
          version: String.t()
        }
  defstruct [:height, :version]

  field :height, 1, type: :uint64
  field :version, 2, type: :string
end
