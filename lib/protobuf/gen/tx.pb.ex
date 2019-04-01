defmodule ForgeAbi.AccountMigrateTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pk: String.t(),
          type: ForgeAbi.WalletType.t(),
          data: Google.Protobuf.Any.t()
        }
  defstruct [:pk, :type, :data]

  field :pk, 1, type: :bytes
  field :type, 2, type: ForgeAbi.WalletType
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.ConsensusUpgradeTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          validators: [ForgeAbi.Validator.t()],
          max_bytes: non_neg_integer,
          max_gas: integer,
          max_validators: non_neg_integer,
          max_candidates: non_neg_integer,
          data: Google.Protobuf.Any.t()
        }
  defstruct [:validators, :max_bytes, :max_gas, :max_validators, :max_candidates, :data]

  field :validators, 1, repeated: true, type: ForgeAbi.Validator
  field :max_bytes, 2, type: :uint64
  field :max_gas, 3, type: :sint64
  field :max_validators, 4, type: :uint32
  field :max_candidates, 5, type: :uint32
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.ConsumeAssetTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          issuer: String.t(),
          address: String.t(),
          data: Google.Protobuf.Any.t()
        }
  defstruct [:issuer, :address, :data]

  field :issuer, 1, type: :string
  field :address, 2, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.CreateAssetTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          moniker: String.t(),
          data: Google.Protobuf.Any.t(),
          readonly: boolean,
          transferrable: boolean,
          ttl: non_neg_integer,
          parent: String.t()
        }
  defstruct [:moniker, :data, :readonly, :transferrable, :ttl, :parent]

  field :moniker, 1, type: :string
  field :data, 2, type: Google.Protobuf.Any
  field :readonly, 3, type: :bool
  field :transferrable, 4, type: :bool
  field :ttl, 5, type: :uint32
  field :parent, 6, type: :string
end

defmodule ForgeAbi.DeclareTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          moniker: String.t(),
          issuer: String.t(),
          data: Google.Protobuf.Any.t()
        }
  defstruct [:moniker, :issuer, :data]

  field :moniker, 1, type: :string
  field :issuer, 2, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.DeclareFileTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t()
        }
  defstruct [:hash]

  field :hash, 1, type: :string
end

defmodule ForgeAbi.DeployProtocol do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          name: String.t(),
          version: non_neg_integer,
          description: String.t(),
          proto: String.t(),
          pipeline: String.t(),
          source: String.t(),
          bin: [String.t()],
          data: Google.Protobuf.Any.t()
        }
  defstruct [:address, :name, :version, :description, :proto, :pipeline, :source, :bin, :data]

  field :address, 1, type: :string
  field :name, 2, type: :string
  field :version, 3, type: :uint32
  field :description, 4, type: :string
  field :proto, 5, type: :string
  field :pipeline, 6, type: :string
  field :source, 7, type: :string
  field :bin, 8, repeated: true, type: :bytes
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.ExchangeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: ForgeAbi.BigUint.t(),
          assets: [String.t()]
        }
  defstruct [:value, :assets]

  field :value, 1, type: ForgeAbi.BigUint
  field :assets, 2, repeated: true, type: :string
end

defmodule ForgeAbi.ExchangeTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          to: String.t(),
          sender: ForgeAbi.ExchangeInfo.t(),
          receiver: ForgeAbi.ExchangeInfo.t(),
          expired_at: Google.Protobuf.Timestamp.t(),
          data: Google.Protobuf.Any.t()
        }
  defstruct [:to, :sender, :receiver, :expired_at, :data]

  field :to, 1, type: :string
  field :sender, 2, type: ForgeAbi.ExchangeInfo
  field :receiver, 3, type: ForgeAbi.ExchangeInfo
  field :expired_at, 4, type: Google.Protobuf.Timestamp
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.StakeForAsset do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ForgeAbi.StakeForChain do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ForgeAbi.StakeForNode do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ForgeAbi.StakeForUser do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ForgeAbi.StakeTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          to: String.t(),
          value: ForgeAbi.BigSint.t(),
          message: String.t(),
          data: Google.Protobuf.Any.t()
        }
  defstruct [:to, :value, :message, :data]

  field :to, 1, type: :string
  field :value, 2, type: ForgeAbi.BigSint
  field :message, 3, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.SysUpgradeTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          task: ForgeAbi.UpgradeTask.t(),
          grace_period: non_neg_integer,
          data: Google.Protobuf.Any.t()
        }
  defstruct [:task, :grace_period, :data]

  field :task, 1, type: ForgeAbi.UpgradeTask
  field :grace_period, 2, type: :uint64
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.TransferTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          to: String.t(),
          value: ForgeAbi.BigUint.t(),
          assets: [String.t()],
          data: Google.Protobuf.Any.t()
        }
  defstruct [:to, :value, :assets, :data]

  field :to, 1, type: :string
  field :value, 2, type: ForgeAbi.BigUint
  field :assets, 3, repeated: true, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.UpdateAssetTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          moniker: String.t(),
          data: Google.Protobuf.Any.t()
        }
  defstruct [:address, :moniker, :data]

  field :address, 1, type: :string
  field :moniker, 2, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.PokeTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          date: String.t(),
          address: String.t(),
          data: Google.Protobuf.Any.t()
        }
  defstruct [:date, :address, :data]

  field :date, 1, type: :string
  field :address, 2, type: :string
  field :data, 15, type: Google.Protobuf.Any
end
