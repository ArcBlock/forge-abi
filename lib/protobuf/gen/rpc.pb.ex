defmodule ForgeAbi.RequestSendTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: ForgeAbi.Transaction.t() | nil,
          wallet: ForgeAbi.WalletInfo.t() | nil,
          token: String.t(),
          commit: boolean
        }
  defstruct [:tx, :wallet, :token, :commit]

  field :tx, 1, type: ForgeAbi.Transaction
  field :wallet, 2, type: ForgeAbi.WalletInfo, deprecated: true
  field :token, 3, type: :string, deprecated: true
  field :commit, 4, type: :bool
end

defmodule ForgeAbi.ResponseSendTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          hash: String.t()
        }
  defstruct [:code, :hash]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :hash, 2, type: :string
end

defmodule ForgeAbi.RequestGetTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t()
        }
  defstruct [:hash]

  field :hash, 1, type: :string
end

defmodule ForgeAbi.ResponseGetTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          info: ForgeAbi.TransactionInfo.t() | nil
        }
  defstruct [:code, :info]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :info, 2, type: ForgeAbi.TransactionInfo
end

defmodule ForgeAbi.RequestGetBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer
        }
  defstruct [:height]

  field :height, 1, type: :uint64
end

defmodule ForgeAbi.ResponseGetBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          block: ForgeAbi.BlockInfo.t() | nil
        }
  defstruct [:code, :block]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :block, 2, type: ForgeAbi.BlockInfo
end

defmodule ForgeAbi.RequestGetBlocks do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t() | nil,
          height_filter: ForgeAbi.RangeFilter.t() | nil,
          empty_excluded: boolean
        }
  defstruct [:paging, :height_filter, :empty_excluded]

  field :paging, 1, type: ForgeAbi.PageInput
  field :height_filter, 2, type: ForgeAbi.RangeFilter
  field :empty_excluded, 3, type: :bool
end

defmodule ForgeAbi.ResponseGetBlocks do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          page: ForgeAbi.PageInfo.t() | nil,
          blocks: [ForgeAbi.BlockInfoSimple.t()]
        }
  defstruct [:code, :page, :blocks]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :blocks, 3, repeated: true, type: ForgeAbi.BlockInfoSimple
end

defmodule ForgeAbi.RequestDeclareNode do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          validator: boolean,
          issuer: String.t()
        }
  defstruct [:validator, :issuer]

  field :validator, 1, type: :bool
  field :issuer, 2, type: :string
end

defmodule ForgeAbi.ResponseDeclareNode do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          wallet: ForgeAbi.WalletInfo.t() | nil,
          tx: ForgeAbi.Transaction.t() | nil
        }
  defstruct [:code, :wallet, :tx]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :wallet, 3, type: ForgeAbi.WalletInfo
  field :tx, 4, type: ForgeAbi.Transaction
end

defmodule ForgeAbi.RequestGetAccountState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          keys: [String.t()],
          height: non_neg_integer
        }
  defstruct [:address, :keys, :height]

  field :address, 1, type: :string
  field :keys, 2, repeated: true, type: :string
  field :height, 3, type: :uint64
end

defmodule ForgeAbi.ResponseGetAccountState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          state: ForgeAbi.AccountState.t() | nil
        }
  defstruct [:code, :state]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :state, 2, type: ForgeAbi.AccountState
end

defmodule ForgeAbi.RequestGetAssetState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          keys: [String.t()],
          height: non_neg_integer
        }
  defstruct [:address, :keys, :height]

  field :address, 1, type: :string
  field :keys, 2, repeated: true, type: :string
  field :height, 3, type: :uint64
end

defmodule ForgeAbi.ResponseGetAssetState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          state: ForgeAbi.AssetState.t() | nil
        }
  defstruct [:code, :state]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :state, 2, type: ForgeAbi.AssetState
end

defmodule ForgeAbi.RequestGetForgeState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          keys: [String.t()],
          height: non_neg_integer
        }
  defstruct [:keys, :height]

  field :keys, 1, repeated: true, type: :string
  field :height, 3, type: :uint64
end

defmodule ForgeAbi.ResponseGetForgeState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          state: ForgeAbi.ForgeState.t() | nil
        }
  defstruct [:code, :state]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :state, 2, type: ForgeAbi.ForgeState
end

defmodule ForgeAbi.RequestGetSwapState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          keys: [String.t()],
          height: non_neg_integer
        }
  defstruct [:address, :keys, :height]

  field :address, 1, type: :string
  field :keys, 2, repeated: true, type: :string
  field :height, 3, type: :uint64
end

defmodule ForgeAbi.ResponseGetSwapState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          state: ForgeAbi.SwapState.t() | nil
        }
  defstruct [:code, :state]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :state, 2, type: ForgeAbi.SwapState
end

defmodule ForgeAbi.RequestGetDelegateState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          keys: [String.t()],
          height: non_neg_integer
        }
  defstruct [:address, :keys, :height]

  field :address, 1, type: :string
  field :keys, 2, repeated: true, type: :string
  field :height, 3, type: :uint64
end

defmodule ForgeAbi.ResponseGetDelegateState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          state: ForgeAbi.DelegateState.t() | nil
        }
  defstruct [:code, :state]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :state, 2, type: ForgeAbi.DelegateState
end

defmodule ForgeAbi.RequestGetChainInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule ForgeAbi.ResponseGetChainInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          info: ForgeAbi.ChainInfo.t() | nil
        }
  defstruct [:code, :info]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :info, 2, type: ForgeAbi.ChainInfo
end

defmodule ForgeAbi.RequestGetNodeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule ForgeAbi.ResponseGetNodeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          info: ForgeAbi.NodeInfo.t() | nil
        }
  defstruct [:code, :info]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :info, 2, type: ForgeAbi.NodeInfo
end

defmodule ForgeAbi.RequestSearch do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule ForgeAbi.ResponseSearch do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          txs: [ForgeAbi.TransactionInfo.t()]
        }
  defstruct [:code, :txs]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :txs, 2, repeated: true, type: ForgeAbi.TransactionInfo
end

defmodule ForgeAbi.RequestGetUnconfirmedTxs do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t() | nil
        }
  defstruct [:paging]

  field :paging, 1, type: ForgeAbi.PageInput
end

defmodule ForgeAbi.ResponseGetUnconfirmedTxs do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          page: ForgeAbi.PageInfo.t() | nil,
          unconfirmed_txs: ForgeAbi.UnconfirmedTxs.t() | nil
        }
  defstruct [:code, :page, :unconfirmed_txs]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :unconfirmed_txs, 3, type: ForgeAbi.UnconfirmedTxs
end

defmodule ForgeAbi.RequestGetNetInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule ForgeAbi.ResponseGetNetInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          net_info: ForgeAbi.NetInfo.t() | nil
        }
  defstruct [:code, :net_info]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :net_info, 2, type: ForgeAbi.NetInfo
end

defmodule ForgeAbi.RequestGetValidatorsInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule ForgeAbi.ResponseGetValidatorsInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          validators_info: ForgeAbi.ValidatorsInfo.t() | nil
        }
  defstruct [:code, :validators_info]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :validators_info, 2, type: ForgeAbi.ValidatorsInfo
end

defmodule ForgeAbi.RequestSubscribe do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          topic: String.t(),
          filter: String.t()
        }
  defstruct [:topic, :filter]

  field :topic, 1, type: :string
  field :filter, 2, type: :string
end

defmodule ForgeAbi.ResponseSubscribe do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any},
          code: ForgeAbi.StatusCode.t()
        }
  defstruct [:value, :code]

  oneof :value, 0
  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :topic, 2, type: :string, oneof: 0
  field :transfer, 3, type: ForgeAbi.Transaction, oneof: 0
  field :account_migrate, 4, type: ForgeAbi.Transaction, oneof: 0
  field :confirm, 5, type: ForgeAbi.Transaction, oneof: 0
  field :create_asset, 6, type: ForgeAbi.Transaction, oneof: 0
  field :exchange, 7, type: ForgeAbi.Transaction, oneof: 0
  field :begin_block, 16, type: AbciVendor.RequestBeginBlock, oneof: 0
  field :end_block, 17, type: AbciVendor.RequestEndBlock, oneof: 0
  field :declare, 19, type: ForgeAbi.Transaction, oneof: 0
  field :update_asset, 20, type: ForgeAbi.Transaction, oneof: 0
  field :consensus_upgrade, 21, type: ForgeAbi.Transaction, oneof: 0
  field :sys_upgrade, 23, type: ForgeAbi.Transaction, oneof: 0
  field :stake, 24, type: ForgeAbi.Transaction, oneof: 0
  field :delegate, 25, type: ForgeAbi.Transaction, oneof: 0
  field :revoke_delegate, 28, type: ForgeAbi.Transaction, oneof: 0
  field :deposit_token, 29, type: ForgeAbi.Transaction, oneof: 0
  field :withdraw_token, 30, type: ForgeAbi.Transaction, oneof: 0
  field :approve_withdraw, 31, type: ForgeAbi.Transaction, oneof: 0
  field :revoke_withdraw, 32, type: ForgeAbi.Transaction, oneof: 0
  field :setup_swap, 33, type: ForgeAbi.Transaction, oneof: 0
  field :revoke_swap, 34, type: ForgeAbi.Transaction, oneof: 0
  field :retrieve_swap, 35, type: ForgeAbi.Transaction, oneof: 0
  field :poke, 36, type: ForgeAbi.Transaction, oneof: 0
  field :consume_asset, 38, type: ForgeAbi.Transaction, oneof: 0
  field :acquire_asset, 39, type: ForgeAbi.Transaction, oneof: 0
  field :upgrade_node, 40, type: ForgeAbi.Transaction, oneof: 0
  field :update_validator, 41, type: ForgeAbi.Transaction, oneof: 0
  field :update_consensus_params, 42, type: ForgeAbi.Transaction, oneof: 0
  field :account_state, 129, type: ForgeAbi.AccountState, oneof: 0
  field :asset_state, 130, type: ForgeAbi.AssetState, oneof: 0
  field :forge_state, 131, type: ForgeAbi.ForgeState, oneof: 0
  field :delegate_state, 134, type: ForgeAbi.DelegateState, oneof: 0
  field :swap_state, 135, type: ForgeAbi.SwapState, oneof: 0
end

defmodule ForgeAbi.RequestUnsubscribe do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          topic: String.t()
        }
  defstruct [:topic]

  field :topic, 1, type: :string
end

defmodule ForgeAbi.ResponseUnsubscribe do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t()
        }
  defstruct [:code]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
end

defmodule ForgeAbi.RequestGetConfig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          parsed: boolean
        }
  defstruct [:parsed]

  field :parsed, 1, type: :bool
end

defmodule ForgeAbi.ResponseGetConfig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          config: String.t()
        }
  defstruct [:code, :config]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :config, 2, type: :string
end

defmodule ForgeAbi.ByDay do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          start_date: String.t(),
          end_date: String.t()
        }
  defstruct [:start_date, :end_date]

  field :start_date, 1, type: :string
  field :end_date, 2, type: :string
end

defmodule ForgeAbi.ByHour do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          date: String.t()
        }
  defstruct [:date]

  field :date, 1, type: :string
end

defmodule ForgeAbi.RequestGetForgeStats do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof :value, 0
  field :day_info, 1, type: ForgeAbi.ByDay, oneof: 0
  field :date, 2, type: ForgeAbi.ByHour, oneof: 0
end

defmodule ForgeAbi.ResponseGetForgeStats do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          forge_stats: ForgeAbi.ForgeStats.t() | nil
        }
  defstruct [:code, :forge_stats]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :forge_stats, 2, type: ForgeAbi.ForgeStats
end

defmodule ForgeAbi.RequestListTransactions do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t() | nil,
          time_filter: ForgeAbi.TimeFilter.t() | nil,
          address_filter: ForgeAbi.AddressFilter.t() | nil,
          type_filter: ForgeAbi.TypeFilter.t() | nil,
          validity_filter: ForgeAbi.ValidityFilter.t() | nil
        }
  defstruct [:paging, :time_filter, :address_filter, :type_filter, :validity_filter]

  field :paging, 1, type: ForgeAbi.PageInput
  field :time_filter, 2, type: ForgeAbi.TimeFilter
  field :address_filter, 3, type: ForgeAbi.AddressFilter
  field :type_filter, 4, type: ForgeAbi.TypeFilter
  field :validity_filter, 5, type: ForgeAbi.ValidityFilter
end

defmodule ForgeAbi.ResponseListTransactions do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          page: ForgeAbi.PageInfo.t() | nil,
          transactions: [ForgeAbi.IndexedTransaction.t()]
        }
  defstruct [:code, :page, :transactions]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :transactions, 3, repeated: true, type: ForgeAbi.IndexedTransaction
end

defmodule ForgeAbi.RequestListAssets do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t() | nil,
          owner_address: String.t()
        }
  defstruct [:paging, :owner_address]

  field :paging, 1, type: ForgeAbi.PageInput
  field :owner_address, 2, type: :string
end

defmodule ForgeAbi.ResponseListAssets do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          page: ForgeAbi.PageInfo.t() | nil,
          assets: [ForgeAbi.IndexedAssetState.t()]
        }
  defstruct [:code, :page, :assets]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :assets, 3, repeated: true, type: ForgeAbi.IndexedAssetState
end

defmodule ForgeAbi.RequestListStakes do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t() | nil,
          address_filter: ForgeAbi.AddressFilter.t() | nil
        }
  defstruct [:paging, :address_filter]

  field :paging, 1, type: ForgeAbi.PageInput
  field :address_filter, 2, type: ForgeAbi.AddressFilter
end

defmodule ForgeAbi.ResponseListStakes do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          page: ForgeAbi.PageInfo.t() | nil,
          stakes: [ForgeAbi.IndexedStakeState.t()]
        }
  defstruct [:code, :page, :stakes]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :stakes, 3, repeated: true, type: ForgeAbi.IndexedStakeState
end

defmodule ForgeAbi.RequestListAccount do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          owner_address: String.t()
        }
  defstruct [:owner_address]

  field :owner_address, 1, type: :string
end

defmodule ForgeAbi.ResponseListAccount do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          account: ForgeAbi.IndexedAccountState.t() | nil
        }
  defstruct [:code, :account]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :account, 2, type: ForgeAbi.IndexedAccountState
end

defmodule ForgeAbi.RequestListTopAccounts do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t() | nil
        }
  defstruct [:paging]

  field :paging, 1, type: ForgeAbi.PageInput
end

defmodule ForgeAbi.ResponseListTopAccounts do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          page: ForgeAbi.PageInfo.t() | nil,
          accounts: [ForgeAbi.IndexedAccountState.t()]
        }
  defstruct [:code, :page, :accounts]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :accounts, 3, repeated: true, type: ForgeAbi.IndexedAccountState
end

defmodule ForgeAbi.RequestListAssetTransactions do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t() | nil,
          address: String.t()
        }
  defstruct [:paging, :address]

  field :paging, 1, type: ForgeAbi.PageInput
  field :address, 2, type: :string
end

defmodule ForgeAbi.ResponseListAssetTransactions do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          page: ForgeAbi.PageInfo.t() | nil,
          transactions: [ForgeAbi.IndexedTransaction.t()]
        }
  defstruct [:code, :page, :transactions]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :transactions, 3, repeated: true, type: ForgeAbi.IndexedTransaction
end

defmodule ForgeAbi.RequestListBlocks do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t() | nil,
          proposer: String.t(),
          time_filter: ForgeAbi.TimeFilter.t() | nil,
          height_filter: ForgeAbi.RangeFilter.t() | nil,
          num_txs_filter: ForgeAbi.RangeFilter.t() | nil,
          num_invalid_txs_filter: ForgeAbi.RangeFilter.t() | nil
        }
  defstruct [
    :paging,
    :proposer,
    :time_filter,
    :height_filter,
    :num_txs_filter,
    :num_invalid_txs_filter
  ]

  field :paging, 1, type: ForgeAbi.PageInput
  field :proposer, 2, type: :string
  field :time_filter, 3, type: ForgeAbi.TimeFilter
  field :height_filter, 4, type: ForgeAbi.RangeFilter
  field :num_txs_filter, 5, type: ForgeAbi.RangeFilter
  field :num_invalid_txs_filter, 6, type: ForgeAbi.RangeFilter
end

defmodule ForgeAbi.ResponseListBlocks do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          page: ForgeAbi.PageInfo.t() | nil,
          blocks: [ForgeAbi.IndexedBlock.t()]
        }
  defstruct [:code, :page, :blocks]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :blocks, 3, repeated: true, type: ForgeAbi.IndexedBlock
end

defmodule ForgeAbi.RequestListSwap do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t() | nil,
          sender: String.t(),
          receiver: String.t(),
          available: boolean
        }
  defstruct [:paging, :sender, :receiver, :available]

  field :paging, 1, type: ForgeAbi.PageInput
  field :sender, 2, type: :string
  field :receiver, 3, type: :string
  field :available, 4, type: :bool
end

defmodule ForgeAbi.ResponseListSwap do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          page: ForgeAbi.PageInfo.t() | nil,
          swap: [ForgeAbi.SwapState.t()]
        }
  defstruct [:code, :page, :swap]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :swap, 3, repeated: true, type: ForgeAbi.SwapState
end

defmodule ForgeAbi.RequestGetSwapStatistics do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t()
        }
  defstruct [:address]

  field :address, 1, type: :string
end

defmodule ForgeAbi.ResponseGetSwapStatistics do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          statistics: ForgeAbi.SwapStatistics.t() | nil
        }
  defstruct [:code, :statistics]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :statistics, 2, type: ForgeAbi.SwapStatistics
end

defmodule ForgeAbi.RequestGetHealthStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{}
  defstruct []
end

defmodule ForgeAbi.ResponseGetHealthStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: ForgeAbi.StatusCode.t(),
          health_status: ForgeAbi.HealthStatus.t() | nil
        }
  defstruct [:code, :health_status]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :health_status, 2, type: ForgeAbi.HealthStatus
end
