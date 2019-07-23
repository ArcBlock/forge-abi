defmodule ForgeAbi.AccountState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          balance: ForgeAbi.BigUint.t() | nil,
          nonce: non_neg_integer,
          num_txs: non_neg_integer,
          address: String.t(),
          pk: binary,
          type: ForgeAbi.WalletType.t() | nil,
          moniker: String.t(),
          context: ForgeAbi.StateContext.t() | nil,
          issuer: String.t(),
          gas_balance: ForgeAbi.BigUint.t() | nil,
          migrated_to: [String.t()],
          migrated_from: [String.t()],
          num_assets: non_neg_integer,
          stake: ForgeAbi.StakeContext.t() | nil,
          pinned_files: ForgeAbi.CircularQueue.t() | nil,
          poke: ForgeAbi.PokeInfo.t() | nil,
          deposit_received: ForgeAbi.BigUint.t() | nil,
          data: Google.Protobuf.Any.t() | nil
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
    :issuer,
    :gas_balance,
    :migrated_to,
    :migrated_from,
    :num_assets,
    :stake,
    :pinned_files,
    :poke,
    :deposit_received,
    :data
  ]

  field :balance, 1, type: ForgeAbi.BigUint
  field :nonce, 2, type: :uint64
  field :num_txs, 3, type: :uint64
  field :address, 4, type: :string
  field :pk, 5, type: :bytes
  field :type, 6, type: ForgeAbi.WalletType, deprecated: true
  field :moniker, 7, type: :string
  field :context, 8, type: ForgeAbi.StateContext
  field :issuer, 9, type: :string
  field :gas_balance, 10, type: ForgeAbi.BigUint
  field :migrated_to, 13, repeated: true, type: :string
  field :migrated_from, 14, repeated: true, type: :string
  field :num_assets, 15, type: :uint64
  field :stake, 16, type: ForgeAbi.StakeContext
  field :pinned_files, 17, type: ForgeAbi.CircularQueue
  field :poke, 18, type: ForgeAbi.PokeInfo
  field :deposit_received, 19, type: ForgeAbi.BigUint
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
          transferrable: boolean,
          ttl: non_neg_integer,
          consumed_time: Google.Protobuf.Timestamp.t() | nil,
          issuer: String.t(),
          parent: String.t(),
          stake: ForgeAbi.StakeContext.t() | nil,
          context: ForgeAbi.StateContext.t() | nil,
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [
    :address,
    :owner,
    :moniker,
    :readonly,
    :transferrable,
    :ttl,
    :consumed_time,
    :issuer,
    :parent,
    :stake,
    :context,
    :data
  ]

  field :address, 1, type: :string
  field :owner, 2, type: :string
  field :moniker, 3, type: :string
  field :readonly, 4, type: :bool
  field :transferrable, 5, type: :bool
  field :ttl, 6, type: :uint32
  field :consumed_time, 7, type: Google.Protobuf.Timestamp
  field :issuer, 8, type: :string
  field :parent, 9, type: :string
  field :stake, 13, type: ForgeAbi.StakeContext
  field :context, 14, type: ForgeAbi.StateContext
  field :data, 50, type: Google.Protobuf.Any
end

defmodule ForgeAbi.CoreProtocol do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          address: String.t()
        }
  defstruct [:name, :address]

  field :name, 1, type: :string
  field :address, 2, type: :string
end

defmodule ForgeAbi.ForgeState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          consensus: ForgeAbi.ConsensusParams.t() | nil,
          tasks: %{non_neg_integer => ForgeAbi.UpgradeTasks.t() | nil},
          stake_summary: %{non_neg_integer => ForgeAbi.StakeSummary.t() | nil},
          version: String.t(),
          forge_app_hash: binary,
          token: ForgeAbi.ForgeToken.t() | nil,
          tx_config: ForgeAbi.TransactionConfig.t() | nil,
          stake_config: ForgeAbi.StakeConfig.t() | nil,
          poke_config: ForgeAbi.PokeConfig.t() | nil,
          protocols: [ForgeAbi.CoreProtocol.t()],
          gas: %{String.t() => non_neg_integer},
          upgrade_info: ForgeAbi.UpgradeInfo.t() | nil,
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [
    :address,
    :consensus,
    :tasks,
    :stake_summary,
    :version,
    :forge_app_hash,
    :token,
    :tx_config,
    :stake_config,
    :poke_config,
    :protocols,
    :gas,
    :upgrade_info,
    :data
  ]

  field :address, 1, type: :string
  field :consensus, 2, type: ForgeAbi.ConsensusParams
  field :tasks, 3, repeated: true, type: ForgeAbi.ForgeState.TasksEntry, map: true
  field :stake_summary, 4, repeated: true, type: ForgeAbi.ForgeState.StakeSummaryEntry, map: true
  field :version, 5, type: :string
  field :forge_app_hash, 7, type: :bytes
  field :token, 8, type: ForgeAbi.ForgeToken
  field :tx_config, 9, type: ForgeAbi.TransactionConfig
  field :stake_config, 10, type: ForgeAbi.StakeConfig
  field :poke_config, 11, type: ForgeAbi.PokeConfig
  field :protocols, 12, repeated: true, type: ForgeAbi.CoreProtocol
  field :gas, 13, repeated: true, type: ForgeAbi.ForgeState.GasEntry, map: true
  field :upgrade_info, 14, type: ForgeAbi.UpgradeInfo
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.ForgeState.TasksEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: non_neg_integer,
          value: ForgeAbi.UpgradeTasks.t() | nil
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
          value: ForgeAbi.StakeSummary.t() | nil
        }
  defstruct [:key, :value]

  field :key, 1, type: :uint32
  field :value, 2, type: ForgeAbi.StakeSummary
end

defmodule ForgeAbi.ForgeState.GasEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: non_neg_integer
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :uint32
end

defmodule ForgeAbi.RootState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          account: binary,
          asset: binary,
          receipt: binary,
          protocol: binary,
          governance: binary,
          custom: binary
        }
  defstruct [:address, :account, :asset, :receipt, :protocol, :governance, :custom]

  field :address, 1, type: :string
  field :account, 2, type: :bytes
  field :asset, 3, type: :bytes
  field :receipt, 4, type: :bytes
  field :protocol, 5, type: :bytes
  field :governance, 6, type: :bytes
  field :custom, 7, type: :bytes
end

defmodule ForgeAbi.StakeState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          from: String.t(),
          to: String.t(),
          balance: ForgeAbi.BigUint.t() | nil,
          message: String.t(),
          context: ForgeAbi.StateContext.t() | nil,
          data: Google.Protobuf.Any.t() | nil
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
          num_stakes: ForgeAbi.BigUint.t() | nil,
          num_validators: non_neg_integer,
          tx_statistics: ForgeAbi.TxStatistics.t() | nil
        }
  defstruct [:address, :num_blocks, :num_txs, :num_stakes, :num_validators, :tx_statistics]

  field :address, 1, type: :string
  field :num_blocks, 2, type: :uint64
  field :num_txs, 3, type: :uint64
  field :num_stakes, 4, type: ForgeAbi.BigUint
  field :num_validators, 5, type: :uint32
  field :tx_statistics, 6, type: ForgeAbi.TxStatistics
end

defmodule ForgeAbi.BlacklistState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: [String.t()]
        }
  defstruct [:address]

  field :address, 1, repeated: true, type: :string
end

defmodule ForgeAbi.ProtocolState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          itx: ForgeAbi.DeployProtocolTx.t() | nil,
          root_hash: binary,
          status: atom | integer,
          migrated_to: [String.t()],
          migrated_from: [String.t()],
          context: ForgeAbi.StateContext.t() | nil,
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:address, :itx, :root_hash, :status, :migrated_to, :migrated_from, :context, :data]

  field :address, 1, type: :string
  field :itx, 2, type: ForgeAbi.DeployProtocolTx
  field :root_hash, 3, type: :bytes
  field :status, 4, type: ForgeAbi.ProtocolStatus, enum: true
  field :migrated_to, 12, repeated: true, type: :string
  field :migrated_from, 13, repeated: true, type: :string
  field :context, 14, type: ForgeAbi.StateContext
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.TetherState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t(),
          available: boolean,
          custodian: String.t(),
          depositor: String.t(),
          withdrawer: String.t(),
          value: ForgeAbi.BigUint.t() | nil,
          commission: ForgeAbi.BigUint.t() | nil,
          charge: ForgeAbi.BigUint.t() | nil,
          target: String.t(),
          locktime: Google.Protobuf.Timestamp.t() | nil,
          address: String.t()
        }
  defstruct [
    :hash,
    :available,
    :custodian,
    :depositor,
    :withdrawer,
    :value,
    :commission,
    :charge,
    :target,
    :locktime,
    :address
  ]

  field :hash, 1, type: :string
  field :available, 2, type: :bool
  field :custodian, 3, type: :string
  field :depositor, 4, type: :string
  field :withdrawer, 5, type: :string
  field :value, 6, type: ForgeAbi.BigUint
  field :commission, 7, type: ForgeAbi.BigUint
  field :charge, 8, type: ForgeAbi.BigUint
  field :target, 9, type: :string
  field :locktime, 10, type: Google.Protobuf.Timestamp
  field :address, 11, type: :string
end

defmodule ForgeAbi.TetherInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          available: boolean,
          hash: String.t()
        }
  defstruct [:available, :hash]

  field :available, 1, type: :bool
  field :hash, 2, type: :string
end

defmodule ForgeAbi.SwapState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t(),
          address: String.t(),
          hashkey: binary,
          sender: String.t(),
          receiver: String.t(),
          value: ForgeAbi.BigUint.t() | nil,
          assets: [String.t()],
          locktime: non_neg_integer,
          hashlock: binary,
          context: ForgeAbi.StateContext.t() | nil
        }
  defstruct [
    :hash,
    :address,
    :hashkey,
    :sender,
    :receiver,
    :value,
    :assets,
    :locktime,
    :hashlock,
    :context
  ]

  field :hash, 1, type: :string
  field :address, 2, type: :string
  field :hashkey, 3, type: :bytes
  field :sender, 4, type: :string
  field :receiver, 5, type: :string
  field :value, 6, type: ForgeAbi.BigUint
  field :assets, 7, repeated: true, type: :string
  field :locktime, 8, type: :uint32
  field :hashlock, 9, type: :bytes
  field :context, 10, type: ForgeAbi.StateContext
end

defmodule ForgeAbi.DelegationState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          ops: [ForgeAbi.DelegateOp.t()],
          context: ForgeAbi.StateContext.t() | nil,
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:address, :ops, :context, :data]

  field :address, 1, type: :string
  field :ops, 2, repeated: true, type: ForgeAbi.DelegateOp
  field :context, 14, type: ForgeAbi.StateContext
  field :data, 15, type: Google.Protobuf.Any
end
