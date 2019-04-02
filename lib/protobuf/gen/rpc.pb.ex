defmodule ForgeAbi.RequestCreateTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          itx: Google.Protobuf.Any.t(),
          from: String.t(),
          nonce: non_neg_integer,
          wallet: ForgeAbi.WalletInfo.t(),
          token: String.t()
        }
  defstruct [:itx, :from, :nonce, :wallet, :token]

  field :itx, 1, type: Google.Protobuf.Any
  field :from, 2, type: :string
  field :nonce, 3, type: :uint64
  field :wallet, 4, type: ForgeAbi.WalletInfo
  field :token, 5, type: :string
end

defmodule ForgeAbi.ResponseCreateTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          tx: ForgeAbi.Transaction.t()
        }
  defstruct [:code, :tx]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :tx, 2, type: ForgeAbi.Transaction
end

defmodule ForgeAbi.RequestMultisig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: ForgeAbi.Transaction.t(),
          data: Google.Protobuf.Any.t(),
          wallet: ForgeAbi.WalletInfo.t(),
          token: String.t()
        }
  defstruct [:tx, :data, :wallet, :token]

  field :tx, 1, type: ForgeAbi.Transaction
  field :data, 2, type: Google.Protobuf.Any
  field :wallet, 3, type: ForgeAbi.WalletInfo
  field :token, 4, type: :string
end

defmodule ForgeAbi.ResponseMultisig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          tx: ForgeAbi.Transaction.t()
        }
  defstruct [:code, :tx]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :tx, 2, type: ForgeAbi.Transaction
end

defmodule ForgeAbi.RequestSendTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: ForgeAbi.Transaction.t(),
          wallet: ForgeAbi.WalletInfo.t(),
          token: String.t(),
          commit: boolean
        }
  defstruct [:tx, :wallet, :token, :commit]

  field :tx, 1, type: ForgeAbi.Transaction
  field :wallet, 2, type: ForgeAbi.WalletInfo
  field :token, 3, type: :string
  field :commit, 4, type: :bool
end

defmodule ForgeAbi.ResponseSendTx do
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
          code: integer,
          info: ForgeAbi.TransactionInfo.t()
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
          code: integer,
          block: ForgeAbi.BlockInfo.t()
        }
  defstruct [:code, :block]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :block, 2, type: ForgeAbi.BlockInfo
end

defmodule ForgeAbi.RequestGetBlocks do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t(),
          min_height: non_neg_integer,
          max_height: non_neg_integer,
          empty_excluded: boolean
        }
  defstruct [:paging, :min_height, :max_height, :empty_excluded]

  field :paging, 1, type: ForgeAbi.PageInput
  field :min_height, 2, type: :uint64
  field :max_height, 3, type: :uint64
  field :empty_excluded, 4, type: :bool
end

defmodule ForgeAbi.ResponseGetBlocks do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          page: ForgeAbi.PageInfo.t(),
          blocks: [ForgeAbi.BlockInfo.t()]
        }
  defstruct [:code, :page, :blocks]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :blocks, 3, repeated: true, type: ForgeAbi.BlockInfo
end

defmodule ForgeAbi.RequestCreateWallet do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          passphrase: String.t(),
          type: ForgeAbi.WalletType.t(),
          moniker: String.t()
        }
  defstruct [:passphrase, :type, :moniker]

  field :passphrase, 1, type: :string
  field :type, 2, type: ForgeAbi.WalletType
  field :moniker, 3, type: :string
end

defmodule ForgeAbi.ResponseCreateWallet do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          token: String.t(),
          wallet: ForgeAbi.WalletInfo.t()
        }
  defstruct [:code, :token, :wallet]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :token, 2, type: :string
  field :wallet, 3, type: ForgeAbi.WalletInfo
end

defmodule ForgeAbi.RequestLoadWallet do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          passphrase: String.t()
        }
  defstruct [:address, :passphrase]

  field :address, 1, type: :string
  field :passphrase, 2, type: :string
end

defmodule ForgeAbi.ResponseLoadWallet do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          token: String.t(),
          wallet: ForgeAbi.WalletInfo.t()
        }
  defstruct [:code, :token, :wallet]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :token, 2, type: :string
  field :wallet, 3, type: ForgeAbi.WalletInfo
end

defmodule ForgeAbi.RequestRecoverWallet do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          data: String.t(),
          type: ForgeAbi.WalletType.t(),
          passphrase: String.t(),
          moniker: String.t()
        }
  defstruct [:data, :type, :passphrase, :moniker]

  field :data, 1, type: :bytes
  field :type, 2, type: ForgeAbi.WalletType
  field :passphrase, 3, type: :string
  field :moniker, 4, type: :string
end

defmodule ForgeAbi.ResponseRecoverWallet do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          token: String.t(),
          wallet: ForgeAbi.WalletInfo.t()
        }
  defstruct [:code, :token, :wallet]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :token, 2, type: :string
  field :wallet, 3, type: ForgeAbi.WalletInfo
end

defmodule ForgeAbi.RequestListWallet do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ForgeAbi.ResponseListWallet do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          address: String.t()
        }
  defstruct [:code, :address]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :address, 2, type: :string
end

defmodule ForgeAbi.RequestRemoveWallet do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t()
        }
  defstruct [:address]

  field :address, 1, type: :string
end

defmodule ForgeAbi.ResponseRemoveWallet do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer
        }
  defstruct [:code]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
end

defmodule ForgeAbi.RequestDeclareNode do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          validator: boolean
        }
  defstruct [:validator]

  field :validator, 1, type: :bool
end

defmodule ForgeAbi.ResponseDeclareNode do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          wallet: ForgeAbi.WalletInfo.t()
        }
  defstruct [:code, :wallet]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :wallet, 3, type: ForgeAbi.WalletInfo
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
          code: integer,
          state: ForgeAbi.AccountState.t()
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
          code: integer,
          state: ForgeAbi.AssetState.t()
        }
  defstruct [:code, :state]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :state, 2, type: ForgeAbi.AssetState
end

defmodule ForgeAbi.RequestGetStakeState do
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

defmodule ForgeAbi.ResponseGetStakeState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          state: ForgeAbi.StakeState.t()
        }
  defstruct [:code, :state]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :state, 2, type: ForgeAbi.StakeState
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
          code: integer,
          state: ForgeAbi.ForgeState.t()
        }
  defstruct [:code, :state]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :state, 2, type: ForgeAbi.ForgeState
end

defmodule ForgeAbi.RequestStoreFile do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          chunk: String.t()
        }
  defstruct [:chunk]

  field :chunk, 1, type: :bytes
end

defmodule ForgeAbi.ResponseStoreFile do
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

defmodule ForgeAbi.RequestLoadFile do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t()
        }
  defstruct [:hash]

  field :hash, 1, type: :string
end

defmodule ForgeAbi.ResponseLoadFile do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          chunk: String.t()
        }
  defstruct [:code, :chunk]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :chunk, 2, type: :bytes
end

defmodule ForgeAbi.RequestPinFile do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t()
        }
  defstruct [:hash]

  field :hash, 1, type: :string
end

defmodule ForgeAbi.ResponsePinFile do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer
        }
  defstruct [:code]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
end

defmodule ForgeAbi.RequestGetChainInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ForgeAbi.ResponseGetChainInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          info: ForgeAbi.ChainInfo.t()
        }
  defstruct [:code, :info]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :info, 2, type: ForgeAbi.ChainInfo
end

defmodule ForgeAbi.RequestGetNodeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ForgeAbi.ResponseGetNodeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          info: ForgeAbi.NodeInfo.t()
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
          code: integer,
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
          limit: non_neg_integer
        }
  defstruct [:limit]

  field :limit, 1, type: :uint32
end

defmodule ForgeAbi.ResponseGetUnconfirmedTxs do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          unconfirmed_txs: ForgeAbi.UnconfirmedTxs.t()
        }
  defstruct [:code, :unconfirmed_txs]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :unconfirmed_txs, 2, type: ForgeAbi.UnconfirmedTxs
end

defmodule ForgeAbi.RequestGetNetInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ForgeAbi.ResponseGetNetInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          net_info: ForgeAbi.NetInfo.t()
        }
  defstruct [:code, :net_info]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :net_info, 2, type: ForgeAbi.NetInfo
end

defmodule ForgeAbi.RequestGetValidatorsInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ForgeAbi.ResponseGetValidatorsInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          validators_info: ForgeAbi.ValidatorsInfo.t()
        }
  defstruct [:code, :validators_info]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :validators_info, 2, type: ForgeAbi.ValidatorsInfo
end

defmodule ForgeAbi.RequestSubscribe do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type: integer,
          filter: String.t()
        }
  defstruct [:type, :filter]

  field :type, 1, type: ForgeAbi.TopicType, enum: true
  field :filter, 2, type: :string
end

defmodule ForgeAbi.ResponseSubscribe do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any},
          code: integer
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
  field :revoke, 8, type: ForgeAbi.Transaction, oneof: 0
  field :begin_block, 16, type: AbciVendor.RequestBeginBlock, oneof: 0
  field :end_block, 17, type: AbciVendor.RequestEndBlock, oneof: 0
  field :declare, 19, type: ForgeAbi.Transaction, oneof: 0
  field :update_asset, 20, type: ForgeAbi.Transaction, oneof: 0
  field :consensus_upgrade, 21, type: ForgeAbi.Transaction, oneof: 0
  field :declare_file, 22, type: ForgeAbi.Transaction, oneof: 0
  field :sys_upgrade, 23, type: ForgeAbi.Transaction, oneof: 0
  field :stake, 24, type: ForgeAbi.Transaction, oneof: 0
  field :account_state, 129, type: ForgeAbi.Transaction, oneof: 0
  field :asset_state, 130, type: ForgeAbi.Transaction, oneof: 0
  field :forge_state, 131, type: ForgeAbi.Transaction, oneof: 0
  field :stake_state, 132, type: ForgeAbi.Transaction, oneof: 0
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
          code: integer
        }
  defstruct [:code]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
end

defmodule ForgeAbi.RequestGetConfig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ForgeAbi.ResponseGetConfig do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
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

defmodule ForgeAbi.RequestGetForgeStatistics do
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

defmodule ForgeAbi.ResponseGetForgeStatistics do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          forge_statistics: ForgeAbi.ForgeStatistics.t()
        }
  defstruct [:code, :forge_statistics]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :forge_statistics, 2, type: ForgeAbi.ForgeStatistics
end

defmodule ForgeAbi.RequestListTransactions do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t(),
          time_filter: ForgeAbi.TimeFilter.t(),
          address_filter: ForgeAbi.AddressFilter.t(),
          type_filter: ForgeAbi.TypeFilter.t(),
          validity_filter: ForgeAbi.ValidityFilter.t()
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
          code: integer,
          page: ForgeAbi.PageInfo.t(),
          transactions: [ForgeAbi.IndexedTransaction.t()]
        }
  defstruct [:code, :page, :transactions]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :transactions, 3, repeated: true, type: ForgeAbi.IndexedTransaction
end

defmodule ForgeAbi.RequestGetAssetAddress do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          sender_address: String.t(),
          itx: ForgeAbi.CreateAssetTx.t(),
          wallet_type: ForgeAbi.WalletType.t()
        }
  defstruct [:sender_address, :itx, :wallet_type]

  field :sender_address, 1, type: :string
  field :itx, 2, type: ForgeAbi.CreateAssetTx
  field :wallet_type, 3, type: ForgeAbi.WalletType
end

defmodule ForgeAbi.ResponseGetAssetAddress do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          asset_address: String.t()
        }
  defstruct [:code, :asset_address]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :asset_address, 2, type: :string
end

defmodule ForgeAbi.RequestSignData do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          data: String.t(),
          wallet: ForgeAbi.WalletInfo.t(),
          token: String.t()
        }
  defstruct [:data, :wallet, :token]

  field :data, 1, type: :bytes
  field :wallet, 2, type: ForgeAbi.WalletInfo
  field :token, 3, type: :string
end

defmodule ForgeAbi.ResponseSignData do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          signature: String.t()
        }
  defstruct [:code, :signature]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :signature, 2, type: :bytes
end

defmodule ForgeAbi.RequestGetAssets do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t(),
          owner_address: String.t()
        }
  defstruct [:paging, :owner_address]

  field :paging, 1, type: ForgeAbi.PageInput
  field :owner_address, 2, type: :string
end

defmodule ForgeAbi.ResponseGetAssets do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          page: ForgeAbi.PageInfo.t(),
          assets: [ForgeAbi.IndexedAssetState.t()]
        }
  defstruct [:code, :page, :assets]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :assets, 3, repeated: true, type: ForgeAbi.IndexedAssetState
end

defmodule ForgeAbi.RequestGetStakes do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t(),
          address_filter: ForgeAbi.AddressFilter.t()
        }
  defstruct [:paging, :address_filter]

  field :paging, 1, type: ForgeAbi.PageInput
  field :address_filter, 2, type: ForgeAbi.AddressFilter
end

defmodule ForgeAbi.ResponseGetStakes do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          page: ForgeAbi.PageInfo.t(),
          stakes: [ForgeAbi.IndexedStakeState.t()]
        }
  defstruct [:code, :page, :stakes]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :stakes, 3, repeated: true, type: ForgeAbi.IndexedStakeState
end

defmodule ForgeAbi.RequestGetTopAccounts do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t()
        }
  defstruct [:paging]

  field :paging, 1, type: ForgeAbi.PageInput
end

defmodule ForgeAbi.ResponseGetTopAccounts do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          page: ForgeAbi.PageInfo.t(),
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
          paging: ForgeAbi.PageInput.t(),
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
          code: integer,
          page: ForgeAbi.PageInfo.t(),
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
          paging: ForgeAbi.PageInput.t(),
          proposer: String.t(),
          time_filter: ForgeAbi.TimeFilter.t(),
          height_filter: ForgeAbi.HeightFilter.t(),
          num_txs_filter: ForgeAbi.NumTxsFilter.t(),
          num_invalid_txs_filter: ForgeAbi.NumInvalidTxsFilter.t()
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
  field :height_filter, 4, type: ForgeAbi.HeightFilter
  field :num_txs_filter, 5, type: ForgeAbi.NumTxsFilter
  field :num_invalid_txs_filter, 6, type: ForgeAbi.NumInvalidTxsFilter
end

defmodule ForgeAbi.ResponseListBlocks do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          page: ForgeAbi.PageInfo.t(),
          blocks: [ForgeAbi.IndexedBlock.t()]
        }
  defstruct [:code, :page, :blocks]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :blocks, 3, repeated: true, type: ForgeAbi.IndexedBlock
end

defmodule ForgeAbi.RequestListAssets do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          paging: ForgeAbi.PageInput.t(),
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
          code: integer,
          page: ForgeAbi.PageInfo.t(),
          account: ForgeAbi.IndexedAccountState.t(),
          assets: [ForgeAbi.IndexedAssetState.t()]
        }
  defstruct [:code, :page, :account, :assets]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :page, 2, type: ForgeAbi.PageInfo
  field :account, 3, type: ForgeAbi.IndexedAccountState
  field :assets, 4, repeated: true, type: ForgeAbi.IndexedAssetState
end

defmodule ForgeAbi.RequestGetHealthStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ForgeAbi.ResponseGetHealthStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          health_status: ForgeAbi.HealthStatus.t()
        }
  defstruct [:code, :health_status]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :health_status, 2, type: ForgeAbi.HealthStatus
end
