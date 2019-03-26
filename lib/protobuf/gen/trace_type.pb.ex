defmodule ForgeAbi.PageOrder do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          field: String.t(),
          type: String.t()
        }
  defstruct [:field, :type]

  field :field, 1, type: :string
  field :type, 2, type: :string
end

defmodule ForgeAbi.PageInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          cursor: String.t(),
          size: non_neg_integer,
          order: [ForgeAbi.PageOrder.t()]
        }
  defstruct [:cursor, :size, :order]

  field :cursor, 1, type: :string
  field :size, 2, type: :uint32
  field :order, 3, repeated: true, type: ForgeAbi.PageOrder
end

defmodule ForgeAbi.TypeFilter do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          types: [String.t()]
        }
  defstruct [:types]

  field :types, 1, repeated: true, type: :string
end

defmodule ForgeAbi.TimeFilter do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          start_date_time: String.t(),
          end_date_time: String.t()
        }
  defstruct [:start_date_time, :end_date_time]

  field :start_date_time, 1, type: :string
  field :end_date_time, 2, type: :string
end

defmodule ForgeAbi.AddressFilter do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          sender: String.t(),
          receiver: String.t(),
          direction: integer
        }
  defstruct [:sender, :receiver, :direction]

  field :sender, 1, type: :string
  field :receiver, 2, type: :string
  field :direction, 3, type: ForgeAbi.Direction, enum: true
end

defmodule ForgeAbi.PageInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          cursor: String.t(),
          next: boolean,
          total: non_neg_integer
        }
  defstruct [:cursor, :next, :total]

  field :cursor, 1, type: :string
  field :next, 2, type: :bool
  field :total, 3, type: :uint32
end

defmodule ForgeAbi.IndexedTransaction do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any},
          hash: String.t(),
          sender: String.t(),
          receiver: String.t(),
          time: String.t(),
          type: String.t(),
          tx: ForgeAbi.Transaction.t()
        }
  defstruct [:value, :hash, :sender, :receiver, :time, :type, :tx]

  oneof :value, 0
  field :hash, 1, type: :string
  field :sender, 2, type: :string
  field :receiver, 3, type: :string
  field :time, 4, type: :string
  field :type, 5, type: :string
  field :tx, 6, type: ForgeAbi.Transaction
  field :consume_asset, 7, type: ForgeAbi.IndexedConsumeAsset, oneof: 0
  field :create_asset, 8, type: ForgeAbi.IndexedCreateAsset, oneof: 0
  field :exchange, 9, type: ForgeAbi.IndexedExchange, oneof: 0
  field :transfer, 10, type: ForgeAbi.IndexedTransfer, oneof: 0
  field :update_asset, 11, type: ForgeAbi.IndexedUpdateAsset, oneof: 0
end

defmodule ForgeAbi.IndexedAccountState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          balance: ForgeAbi.BigUint.t(),
          num_assets: non_neg_integer,
          num_txs: non_neg_integer,
          nonce: non_neg_integer,
          genesis_time: String.t(),
          renaissance_time: String.t(),
          moniker: String.t(),
          migrated_from: String.t(),
          migrated_to: String.t(),
          total_received_stakes: ForgeAbi.BigUint.t(),
          total_stakes: ForgeAbi.BigUint.t(),
          total_unstakes: ForgeAbi.BigUint.t(),
          recent_num_txs: [non_neg_integer]
        }
  defstruct [
    :address,
    :balance,
    :num_assets,
    :num_txs,
    :nonce,
    :genesis_time,
    :renaissance_time,
    :moniker,
    :migrated_from,
    :migrated_to,
    :total_received_stakes,
    :total_stakes,
    :total_unstakes,
    :recent_num_txs
  ]

  field :address, 1, type: :string
  field :balance, 2, type: ForgeAbi.BigUint
  field :num_assets, 3, type: :uint64
  field :num_txs, 4, type: :uint64
  field :nonce, 5, type: :uint64
  field :genesis_time, 6, type: :string
  field :renaissance_time, 7, type: :string
  field :moniker, 8, type: :string
  field :migrated_from, 9, type: :string
  field :migrated_to, 10, type: :string
  field :total_received_stakes, 11, type: ForgeAbi.BigUint
  field :total_stakes, 12, type: ForgeAbi.BigUint
  field :total_unstakes, 13, type: ForgeAbi.BigUint
  field :recent_num_txs, 14, repeated: true, type: :uint64
end

defmodule ForgeAbi.IndexedAssetState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          owner: String.t(),
          genesis_time: String.t(),
          renaissance_time: String.t(),
          moniker: String.t(),
          readonly: boolean
        }
  defstruct [:address, :owner, :genesis_time, :renaissance_time, :moniker, :readonly]

  field :address, 1, type: :string
  field :owner, 2, type: :string
  field :genesis_time, 3, type: :string
  field :renaissance_time, 4, type: :string
  field :moniker, 5, type: :string
  field :readonly, 6, type: :bool
end

defmodule ForgeAbi.IndexedStakeState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          balance: ForgeAbi.BigUint.t(),
          sender: String.t(),
          receiver: String.t(),
          genesis_time: String.t(),
          renaissance_time: String.t(),
          message: String.t(),
          type: non_neg_integer
        }
  defstruct [
    :address,
    :balance,
    :sender,
    :receiver,
    :genesis_time,
    :renaissance_time,
    :message,
    :type
  ]

  field :address, 1, type: :string
  field :balance, 2, type: ForgeAbi.BigUint
  field :sender, 3, type: :string
  field :receiver, 4, type: :string
  field :genesis_time, 5, type: :string
  field :renaissance_time, 6, type: :string
  field :message, 7, type: :string
  field :type, 8, type: :uint32
end

defmodule ForgeAbi.IndexedConsumeAsset do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          asset: String.t()
        }
  defstruct [:asset]

  field :asset, 1, type: :string
end

defmodule ForgeAbi.IndexedCreateAsset do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          asset: String.t()
        }
  defstruct [:asset]

  field :asset, 1, type: :string
end

defmodule ForgeAbi.IndexedExchange do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          sender_assets: [String.t()],
          receiver_assets: [String.t()]
        }
  defstruct [:sender_assets, :receiver_assets]

  field :sender_assets, 1, repeated: true, type: :string
  field :receiver_assets, 2, repeated: true, type: :string
end

defmodule ForgeAbi.IndexedTransfer do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          assets: [String.t()]
        }
  defstruct [:assets]

  field :assets, 1, repeated: true, type: :string
end

defmodule ForgeAbi.IndexedUpdateAsset do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          asset: String.t()
        }
  defstruct [:asset]

  field :asset, 1, type: :string
end

defmodule ForgeAbi.HeightFilter do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          from_height: non_neg_integer,
          to_height: non_neg_integer
        }
  defstruct [:from_height, :to_height]

  field :from_height, 1, type: :uint64
  field :to_height, 2, type: :uint64
end

defmodule ForgeAbi.NumTxsFilter do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          min_num_txs: non_neg_integer,
          max_num_txs: non_neg_integer
        }
  defstruct [:min_num_txs, :max_num_txs]

  field :min_num_txs, 1, type: :uint64
  field :max_num_txs, 2, type: :uint64
end

defmodule ForgeAbi.NumInvalidTxsFilter do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          min_num_invalid_txs: non_neg_integer,
          max_num_invalid_txs: non_neg_integer
        }
  defstruct [:min_num_invalid_txs, :max_num_invalid_txs]

  field :min_num_invalid_txs, 1, type: :uint64
  field :max_num_invalid_txs, 2, type: :uint64
end

defmodule ForgeAbi.IndexedBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer,
          time: String.t(),
          proposer: String.t(),
          num_txs: non_neg_integer,
          num_invalid_txs: non_neg_integer
        }
  defstruct [:height, :time, :proposer, :num_txs, :num_invalid_txs]

  field :height, 1, type: :uint64
  field :time, 2, type: :string
  field :proposer, 3, type: :string
  field :num_txs, 4, type: :uint64
  field :num_invalid_txs, 5, type: :uint64
end

defmodule ForgeAbi.HealthStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          consensus: ForgeAbi.ConsensusStatus.t(),
          network: ForgeAbi.NetworkStatus.t(),
          storage: ForgeAbi.StorageStatus.t(),
          forge: ForgeAbi.ForgeStatus.t()
        }
  defstruct [:consensus, :network, :storage, :forge]

  field :consensus, 1, type: ForgeAbi.ConsensusStatus
  field :network, 2, type: ForgeAbi.NetworkStatus
  field :storage, 3, type: ForgeAbi.StorageStatus
  field :forge, 4, type: ForgeAbi.ForgeStatus
end

defmodule ForgeAbi.ConsensusStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          health: boolean,
          synced: boolean,
          block_height: non_neg_integer
        }
  defstruct [:health, :synced, :block_height]

  field :health, 1, type: :bool
  field :synced, 2, type: :bool
  field :block_height, 3, type: :uint64
end

defmodule ForgeAbi.NetworkStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          health: boolean,
          num_peers: non_neg_integer
        }
  defstruct [:health, :num_peers]

  field :health, 1, type: :bool
  field :num_peers, 2, type: :uint32
end

defmodule ForgeAbi.StorageStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          health: boolean,
          indexer_server: String.t(),
          state_db: String.t(),
          disk_space: ForgeAbi.DiskSpaceStatus.t()
        }
  defstruct [:health, :indexer_server, :state_db, :disk_space]

  field :health, 1, type: :bool
  field :indexer_server, 2, type: :string
  field :state_db, 3, type: :string
  field :disk_space, 4, type: ForgeAbi.DiskSpaceStatus
end

defmodule ForgeAbi.DiskSpaceStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          forge_usage: String.t(),
          total: String.t()
        }
  defstruct [:forge_usage, :total]

  field :forge_usage, 1, type: :string
  field :total, 2, type: :string
end

defmodule ForgeAbi.ForgeStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          health: boolean,
          abi_server: String.t(),
          forge_web: String.t(),
          abci_server: ForgeAbi.AbciServerStatus.t()
        }
  defstruct [:health, :abi_server, :forge_web, :abci_server]

  field :health, 1, type: :bool
  field :abi_server, 2, type: :string
  field :forge_web, 3, type: :string
  field :abci_server, 4, type: ForgeAbi.AbciServerStatus
end

defmodule ForgeAbi.AbciServerStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          abci_consensus: String.t(),
          abci_info: String.t()
        }
  defstruct [:abci_consensus, :abci_info]

  field :abci_consensus, 1, type: :string
  field :abci_info, 2, type: :string
end

defmodule ForgeAbi.Direction do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :mutual, 0
  field :one_way, 1
  field :union, 2
end
