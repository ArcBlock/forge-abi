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
          hash: String.t(),
          sender: String.t(),
          receiver: String.t(),
          time: String.t(),
          type: String.t(),
          tx: ForgeAbi.Transaction.t()
        }
  defstruct [:hash, :sender, :receiver, :time, :type, :tx]

  field :hash, 1, type: :string
  field :sender, 2, type: :string
  field :receiver, 3, type: :string
  field :time, 4, type: :string
  field :type, 5, type: :string
  field :tx, 6, type: ForgeAbi.Transaction
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
          total_unstakes: ForgeAbi.BigUint.t()
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
    :total_unstakes
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

defmodule ForgeAbi.Direction do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :mutual, 0
  field :one_way, 1
  field :union, 2
end
