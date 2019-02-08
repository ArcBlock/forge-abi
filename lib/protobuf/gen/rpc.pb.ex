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
          wallet: ForgeAbi.WalletInfo.t(),
          token: String.t()
        }
  defstruct [:tx, :wallet, :token]

  field :tx, 1, type: ForgeAbi.Transaction
  field :wallet, 2, type: ForgeAbi.WalletInfo
  field :token, 3, type: :string
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
          min_height: non_neg_integer,
          max_height: non_neg_integer
        }
  defstruct [:min_height, :max_height]

  field :min_height, 1, type: :uint64
  field :max_height, 2, type: :uint64
end

defmodule ForgeAbi.ResponseGetBlocks do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          blocks: [ForgeAbi.BlockInfo.t()]
        }
  defstruct [:code, :blocks]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :blocks, 2, repeated: true, type: ForgeAbi.BlockInfo
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
          app_hash: String.t()
        }
  defstruct [:address, :keys, :app_hash]

  field :address, 1, type: :string
  field :keys, 2, repeated: true, type: :string
  field :app_hash, 3, type: :string
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
          app_hash: String.t()
        }
  defstruct [:address, :keys, :app_hash]

  field :address, 1, type: :string
  field :keys, 2, repeated: true, type: :string
  field :app_hash, 3, type: :string
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
          app_hash: String.t()
        }
  defstruct [:address, :keys, :app_hash]

  field :address, 1, type: :string
  field :keys, 2, repeated: true, type: :string
  field :app_hash, 3, type: :string
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
          app_hash: String.t()
        }
  defstruct [:keys, :app_hash]

  field :keys, 1, repeated: true, type: :string
  field :app_hash, 2, type: :string
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
