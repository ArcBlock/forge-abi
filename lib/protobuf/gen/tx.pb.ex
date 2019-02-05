defmodule ForgeAbi.AccountMigrateTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pk: String.t(),
          type: ForgeAbi.WalletType.t()
        }
  defstruct [:pk, :type]

  field :pk, 1, type: :bytes
  field :type, 2, type: ForgeAbi.WalletType
end

defmodule ForgeAbi.ConsensusUpgradeTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          validators: [ForgeAbi.Validator.t()]
        }
  defstruct [:validators]

  field :validators, 1, repeated: true, type: ForgeAbi.Validator
end

defmodule ForgeAbi.CreateAssetTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          moniker: String.t(),
          data: Google.Protobuf.Any.t(),
          readonly: boolean
        }
  defstruct [:moniker, :data, :readonly]

  field :moniker, 1, type: :string
  field :data, 2, type: Google.Protobuf.Any
  field :readonly, 3, type: :bool
end

defmodule ForgeAbi.DeclareTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          moniker: String.t(),
          pk: String.t(),
          type: ForgeAbi.WalletType.t()
        }
  defstruct [:moniker, :pk, :type]

  field :moniker, 1, type: :string
  field :pk, 2, type: :bytes
  field :type, 3, type: ForgeAbi.WalletType
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
          expired_at: Google.Protobuf.Timestamp.t()
        }
  defstruct [:to, :sender, :receiver, :expired_at]

  field :to, 1, type: :string
  field :sender, 2, type: ForgeAbi.ExchangeInfo
  field :receiver, 3, type: ForgeAbi.ExchangeInfo
  field :expired_at, 4, type: Google.Protobuf.Timestamp
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
          grace_period: non_neg_integer
        }
  defstruct [:task, :grace_period]

  field :task, 1, type: ForgeAbi.UpgradeTask
  field :grace_period, 2, type: :uint64
end

defmodule ForgeAbi.TransferTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          to: String.t(),
          value: ForgeAbi.BigUint.t(),
          assets: [String.t()]
        }
  defstruct [:to, :value, :assets]

  field :to, 1, type: :string
  field :value, 2, type: ForgeAbi.BigUint
  field :assets, 3, repeated: true, type: :string
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
  field :data, 3, type: Google.Protobuf.Any
end
