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
          withdraw_items: ForgeAbi.CircularQueue.t() | nil,
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
    :withdraw_items,
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
  field :withdraw_items, 20, type: ForgeAbi.CircularQueue
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

defmodule ForgeAbi.ForgeState.AccountConfigEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: ForgeAbi.AccountConfig.t() | nil
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: ForgeAbi.AccountConfig
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
          token: ForgeAbi.ForgeToken.t() | nil,
          tx_config: ForgeAbi.TransactionConfig.t() | nil,
          protocols: [ForgeAbi.CoreProtocol.t()],
          gas: %{String.t() => non_neg_integer},
          upgrade_info: ForgeAbi.UpgradeInfo.t() | nil,
          account_config: %{String.t() => ForgeAbi.AccountConfig.t() | nil},
          token_swap_config: ForgeAbi.TokenSwapConfig.t() | nil,
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [
    :address,
    :consensus,
    :tasks,
    :stake_summary,
    :version,
    :token,
    :tx_config,
    :protocols,
    :gas,
    :upgrade_info,
    :account_config,
    :token_swap_config,
    :data
  ]

  field :address, 1, type: :string
  field :consensus, 2, type: ForgeAbi.ConsensusParams
  field :tasks, 3, repeated: true, type: ForgeAbi.ForgeState.TasksEntry, map: true
  field :stake_summary, 4, repeated: true, type: ForgeAbi.ForgeState.StakeSummaryEntry, map: true
  field :version, 5, type: :string
  field :token, 8, type: ForgeAbi.ForgeToken
  field :tx_config, 9, type: ForgeAbi.TransactionConfig
  field :protocols, 12, repeated: true, type: ForgeAbi.CoreProtocol
  field :gas, 13, repeated: true, type: ForgeAbi.ForgeState.GasEntry, map: true
  field :upgrade_info, 14, type: ForgeAbi.UpgradeInfo

  field :account_config, 16,
    repeated: true,
    type: ForgeAbi.ForgeState.AccountConfigEntry,
    map: true

  field :token_swap_config, 17, type: ForgeAbi.TokenSwapConfig
  field :data, 2047, type: Google.Protobuf.Any
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
          status: ForgeAbi.ProtocolStatus.t(),
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

defmodule ForgeAbi.SwapStatistics do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          locked_value_out: ForgeAbi.BigUint.t() | nil,
          locked_value_in: ForgeAbi.BigUint.t() | nil,
          locked_assets_out: non_neg_integer,
          locked_assets_in: non_neg_integer
        }
  defstruct [:address, :locked_value_out, :locked_value_in, :locked_assets_out, :locked_assets_in]

  field :address, 1, type: :string
  field :locked_value_out, 2, type: ForgeAbi.BigUint
  field :locked_value_in, 3, type: ForgeAbi.BigUint
  field :locked_assets_out, 4, type: :uint32
  field :locked_assets_in, 5, type: :uint32
end

defmodule ForgeAbi.DelegateOpState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          rule: String.t(),
          num_txs: non_neg_integer,
          num_txs_delta: non_neg_integer,
          balance: ForgeAbi.BigUint.t() | nil,
          balance_delta: ForgeAbi.BigUint.t() | nil
        }
  defstruct [:rule, :num_txs, :num_txs_delta, :balance, :balance_delta]

  field :rule, 1, type: :string
  field :num_txs, 2, type: :uint64
  field :num_txs_delta, 3, type: :uint64
  field :balance, 4, type: ForgeAbi.BigUint
  field :balance_delta, 5, type: ForgeAbi.BigUint
end

defmodule ForgeAbi.DelegateState.OpsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: ForgeAbi.DelegateOpState.t() | nil
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: ForgeAbi.DelegateOpState
end

defmodule ForgeAbi.DelegateState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          ops: %{String.t() => ForgeAbi.DelegateOpState.t() | nil},
          context: ForgeAbi.StateContext.t() | nil,
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:address, :ops, :context, :data]

  field :address, 1, type: :string
  field :ops, 2, repeated: true, type: ForgeAbi.DelegateState.OpsEntry, map: true
  field :context, 14, type: ForgeAbi.StateContext
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.AssetFactoryState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          description: String.t(),
          limit: non_neg_integer,
          price: ForgeAbi.BigUint.t() | nil,
          template: String.t(),
          allowed_spec_args: [String.t()],
          asset_name: String.t(),
          attributes: ForgeAbi.AssetAttributes.t() | nil,
          num_created: non_neg_integer,
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [
    :description,
    :limit,
    :price,
    :template,
    :allowed_spec_args,
    :asset_name,
    :attributes,
    :num_created,
    :data
  ]

  field :description, 1, type: :string
  field :limit, 2, type: :uint32
  field :price, 3, type: ForgeAbi.BigUint
  field :template, 4, type: :string
  field :allowed_spec_args, 5, repeated: true, type: :string
  field :asset_name, 6, type: :string
  field :attributes, 7, type: ForgeAbi.AssetAttributes
  field :num_created, 8, type: :uint32
  field :data, 15, type: Google.Protobuf.Any
end
