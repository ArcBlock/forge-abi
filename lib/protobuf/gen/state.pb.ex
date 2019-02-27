defmodule ForgeAbi.AccountState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          balance: ForgeAbi.BigUint.t(),
          nonce: non_neg_integer,
          num_txs: non_neg_integer,
          address: String.t(),
          pk: String.t(),
          type: ForgeAbi.WalletType.t(),
          moniker: String.t(),
          context: ForgeAbi.StateContext.t(),
          migrated_to: [String.t()],
          migrated_from: [String.t()],
          num_assets: non_neg_integer,
          stake: ForgeAbi.StakeContext.t(),
          pinned_files: ForgeAbi.CircularQueue.t(),
          data: Google.Protobuf.Any.t()
        }
  defstruct [
    :balance,
    :nonce,
    :num_txs,
    :address,
    :pk,
    :type,
    :moniker,
    :context,
    :migrated_to,
    :migrated_from,
    :num_assets,
    :stake,
    :pinned_files,
    :data
  ]

  field :balance, 1, type: ForgeAbi.BigUint
  field :nonce, 2, type: :uint64
  field :num_txs, 3, type: :uint64
  field :address, 4, type: :string
  field :pk, 5, type: :bytes
  field :type, 6, type: ForgeAbi.WalletType
  field :moniker, 7, type: :string
  field :context, 8, type: ForgeAbi.StateContext
  field :migrated_to, 13, repeated: true, type: :string
  field :migrated_from, 14, repeated: true, type: :string
  field :num_assets, 15, type: :uint64
  field :stake, 16, type: ForgeAbi.StakeContext
  field :pinned_files, 17, type: ForgeAbi.CircularQueue
  field :data, 50, type: Google.Protobuf.Any
end

defmodule ForgeAbi.AssetState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          owner: String.t(),
          moniker: String.t(),
          readonly: boolean,
          activated: boolean,
          expired_at: Google.Protobuf.Timestamp.t(),
          stake: ForgeAbi.StakeContext.t(),
          context: ForgeAbi.StateContext.t(),
          data: Google.Protobuf.Any.t()
        }
  defstruct [
    :address,
    :owner,
    :moniker,
    :readonly,
    :activated,
    :expired_at,
    :stake,
    :context,
    :data
  ]

  field :address, 1, type: :string
  field :owner, 2, type: :string
  field :moniker, 3, type: :string
  field :readonly, 4, type: :bool
  field :activated, 5, type: :bool
  field :expired_at, 6, type: Google.Protobuf.Timestamp
  field :stake, 13, type: ForgeAbi.StakeContext
  field :context, 14, type: ForgeAbi.StateContext
  field :data, 50, type: Google.Protobuf.Any
end

defmodule ForgeAbi.ForgeState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          consensus: ForgeAbi.ConsensusParams.t(),
          tasks: %{non_neg_integer => ForgeAbi.UpgradeTasks.t()},
          stake_summary: %{non_neg_integer => ForgeAbi.StakeSummary.t()},
          version: String.t(),
          data_version: String.t(),
          forge_app_hash: String.t(),
          data: Google.Protobuf.Any.t()
        }
  defstruct [
    :address,
    :consensus,
    :tasks,
    :stake_summary,
    :version,
    :data_version,
    :forge_app_hash,
    :data
  ]

  field :address, 1, type: :string
  field :consensus, 2, type: ForgeAbi.ConsensusParams
  field :tasks, 3, repeated: true, type: ForgeAbi.ForgeState.TasksEntry, map: true
  field :stake_summary, 4, repeated: true, type: ForgeAbi.ForgeState.StakeSummaryEntry, map: true
  field :version, 5, type: :string
  field :data_version, 6, type: :string
  field :forge_app_hash, 7, type: :bytes
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.ForgeState.TasksEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: non_neg_integer,
          value: ForgeAbi.UpgradeTasks.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :uint64
  field :value, 2, type: ForgeAbi.UpgradeTasks
end

defmodule ForgeAbi.ForgeState.StakeSummaryEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: non_neg_integer,
          value: ForgeAbi.StakeSummary.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :uint32
  field :value, 2, type: ForgeAbi.StakeSummary
end

defmodule ForgeAbi.RootState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          account: String.t(),
          asset: String.t(),
          receipt: String.t()
        }
  defstruct [:address, :account, :asset, :receipt]

  field :address, 1, type: :string
  field :account, 2, type: :bytes
  field :asset, 3, type: :bytes
  field :receipt, 4, type: :bytes
end

defmodule ForgeAbi.StakeState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          from: String.t(),
          to: String.t(),
          balance: ForgeAbi.BigUint.t(),
          message: String.t(),
          context: ForgeAbi.StateContext.t(),
          data: Google.Protobuf.Any.t()
        }
  defstruct [:address, :from, :to, :balance, :message, :context, :data]

  field :address, 1, type: :string
  field :from, 2, type: :string
  field :to, 3, type: :string
  field :balance, 4, type: ForgeAbi.BigUint
  field :message, 5, type: :string
  field :context, 14, type: ForgeAbi.StateContext
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.StatisticsState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          num_blocks: non_neg_integer,
          num_txs: non_neg_integer,
          num_stakes: ForgeAbi.BigUint.t(),
          num_validators: non_neg_integer,
          tx_statistics: ForgeAbi.TxStatistics.t()
        }
  defstruct [:address, :num_blocks, :num_txs, :num_stakes, :num_validators, :tx_statistics]

  field :address, 1, type: :string
  field :num_blocks, 2, type: :uint64
  field :num_txs, 3, type: :uint64
  field :num_stakes, 4, type: ForgeAbi.BigUint
  field :num_validators, 5, type: :uint32
  field :tx_statistics, 6, type: ForgeAbi.TxStatistics
end
