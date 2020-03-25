defmodule ForgeAbi.CodeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          checksum: binary,
          binary: binary
        }
  defstruct [:checksum, :binary]

  field :checksum, 1, type: :bytes
  field :binary, 2, type: :bytes
end

defmodule ForgeAbi.TypeUrls do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          url: String.t(),
          module: String.t()
        }
  defstruct [:url, :module]

  field :url, 1, type: :string
  field :module, 2, type: :string
end

defmodule ForgeAbi.DeployProtocolTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          name: String.t(),
          version: non_neg_integer,
          namespace: String.t(),
          description: String.t(),
          type_urls: [ForgeAbi.TypeUrls.t()],
          proto: String.t(),
          pipeline: String.t(),
          sources: [String.t()],
          code: [ForgeAbi.CodeInfo.t()],
          tags: [String.t()],
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [
    :address,
    :name,
    :version,
    :namespace,
    :description,
    :type_urls,
    :proto,
    :pipeline,
    :sources,
    :code,
    :tags,
    :data
  ]

  field :address, 1, type: :string
  field :name, 2, type: :string
  field :version, 3, type: :uint32
  field :namespace, 4, type: :string
  field :description, 5, type: :string
  field :type_urls, 6, repeated: true, type: ForgeAbi.TypeUrls
  field :proto, 7, type: :string
  field :pipeline, 8, type: :string
  field :sources, 9, repeated: true, type: :string
  field :code, 10, repeated: true, type: ForgeAbi.CodeInfo
  field :tags, 11, repeated: true, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.AccountMigrateTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pk: binary,
          type: ForgeAbi.WalletType.t() | nil,
          address: String.t(),
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:pk, :type, :address, :data]

  field :pk, 1, type: :bytes
  field :type, 2, type: ForgeAbi.WalletType, deprecated: true
  field :address, 3, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.DeclareTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          moniker: String.t(),
          issuer: String.t(),
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:moniker, :issuer, :data]

  field :moniker, 1, type: :string
  field :issuer, 2, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.DelegateTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          to: String.t(),
          ops: [ForgeAbi.DelegateOp.t()],
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:address, :to, :ops, :data]

  field :address, 1, type: :string
  field :to, 2, type: :string
  field :ops, 3, repeated: true, type: ForgeAbi.DelegateOp
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.DelegateOp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type_url: String.t(),
          rules: [String.t()]
        }
  defstruct [:type_url, :rules]

  field :type_url, 1, type: :string
  field :rules, 2, repeated: true, type: :string
end

defmodule ForgeAbi.RevokeDelegateTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          to: String.t(),
          type_urls: [String.t()],
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:address, :to, :type_urls, :data]

  field :address, 1, type: :string
  field :to, 2, type: :string
  field :type_urls, 3, repeated: true, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.AssetSpec do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          data: String.t()
        }
  defstruct [:address, :data]

  field :address, 1, type: :string
  field :data, 2, type: :string
end

defmodule ForgeAbi.AcquireAssetTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          to: String.t(),
          specs: [ForgeAbi.AssetSpec.t()],
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:to, :specs, :data]

  field :to, 1, type: :string
  field :specs, 2, repeated: true, type: ForgeAbi.AssetSpec
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.ConsumeAssetTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          issuer: String.t(),
          address: String.t(),
          data: Google.Protobuf.Any.t() | nil
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
          data: Google.Protobuf.Any.t() | nil,
          readonly: boolean,
          transferrable: boolean,
          ttl: non_neg_integer,
          parent: String.t(),
          address: String.t()
        }
  defstruct [:moniker, :data, :readonly, :transferrable, :ttl, :parent, :address]

  field :moniker, 1, type: :string
  field :data, 2, type: Google.Protobuf.Any
  field :readonly, 3, type: :bool
  field :transferrable, 4, type: :bool
  field :ttl, 5, type: :uint32
  field :parent, 6, type: :string
  field :address, 7, type: :string
end

defmodule ForgeAbi.AssetAttributes do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          transferrable: boolean,
          ttl: non_neg_integer
        }
  defstruct [:transferrable, :ttl]

  field :transferrable, 1, type: :bool
  field :ttl, 2, type: :uint32
end

defmodule ForgeAbi.AssetFactory do
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
    :data
  ]

  field :description, 1, type: :string
  field :limit, 2, type: :uint32
  field :price, 3, type: ForgeAbi.BigUint
  field :template, 4, type: :string
  field :allowed_spec_args, 5, repeated: true, type: :string
  field :asset_name, 6, type: :string
  field :attributes, 7, type: ForgeAbi.AssetAttributes
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.UpdateAssetTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          moniker: String.t(),
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:address, :moniker, :data]

  field :address, 1, type: :string
  field :moniker, 2, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.UpdateConsensusParamsTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          delegate_config: ForgeAbi.DelegateConfig.t() | nil,
          declare_config: ForgeAbi.DeclareConfig.t() | nil,
          token_swap_config: ForgeAbi.TokenSwapConfig.t() | nil,
          moderator_config: ForgeAbi.AccountConfig.t() | nil
        }
  defstruct [:delegate_config, :declare_config, :token_swap_config, :moderator_config]

  field :delegate_config, 1, type: ForgeAbi.DelegateConfig
  field :declare_config, 2, type: ForgeAbi.DeclareConfig
  field :token_swap_config, 3, type: ForgeAbi.TokenSwapConfig
  field :moderator_config, 4, type: ForgeAbi.AccountConfig
end

defmodule ForgeAbi.UpdateValidatorTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          candidates: [ForgeAbi.Validator.t()],
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:candidates, :data]

  field :candidates, 1, repeated: true, type: ForgeAbi.Validator
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.UpgradeNodeTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: non_neg_integer,
          version: String.t(),
          override: boolean
        }
  defstruct [:height, :version, :override]

  field :height, 1, type: :uint64
  field :version, 2, type: :string
  field :override, 3, type: :bool
end

defmodule ForgeAbi.ActivateProtocolTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:address, :data]

  field :address, 1, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.DeactivateProtocolTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:address, :data]

  field :address, 1, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.PokeTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          date: String.t(),
          address: String.t(),
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:date, :address, :data]

  field :date, 1, type: :string
  field :address, 2, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.RefuelTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          date: String.t(),
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:date, :data]

  field :date, 1, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.RetrieveSwapTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          hashkey: binary,
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:address, :hashkey, :data]

  field :address, 1, type: :string
  field :hashkey, 2, type: :bytes
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.RevokeSwapTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:address, :data]

  field :address, 1, type: :string
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.SetupSwapTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: ForgeAbi.BigUint.t() | nil,
          assets: [String.t()],
          receiver: String.t(),
          hashlock: binary,
          locktime: non_neg_integer,
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:value, :assets, :receiver, :hashlock, :locktime, :data]

  field :value, 1, type: ForgeAbi.BigUint
  field :assets, 2, repeated: true, type: :string
  field :receiver, 3, type: :string
  field :hashlock, 4, type: :bytes
  field :locktime, 5, type: :uint32
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.ApproveWithdrawTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          withdraw_tx_hash: String.t(),
          evidence: ForgeAbi.Evidence.t() | nil
        }
  defstruct [:withdraw_tx_hash, :evidence]

  field :withdraw_tx_hash, 1, type: :string
  field :evidence, 2, type: ForgeAbi.Evidence
end

defmodule ForgeAbi.DepositTokenTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: ForgeAbi.BigUint.t() | nil,
          address: String.t(),
          evidence: ForgeAbi.Evidence.t() | nil
        }
  defstruct [:value, :address, :evidence]

  field :value, 1, type: ForgeAbi.BigUint
  field :address, 2, type: :string
  field :evidence, 3, type: ForgeAbi.Evidence
end

defmodule ForgeAbi.RevokeWithdrawTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          withdraw_tx_hash: String.t()
        }
  defstruct [:withdraw_tx_hash]

  field :withdraw_tx_hash, 1, type: :string
end

defmodule ForgeAbi.WithdrawTokenTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: ForgeAbi.BigUint.t() | nil,
          to: String.t(),
          chain_type: String.t(),
          chain_id: String.t()
        }
  defstruct [:value, :to, :chain_type, :chain_id]

  field :value, 1, type: ForgeAbi.BigUint
  field :to, 2, type: :string
  field :chain_type, 3, type: :string
  field :chain_id, 4, type: :string
end

defmodule ForgeAbi.ExchangeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: ForgeAbi.BigUint.t() | nil,
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
          sender: ForgeAbi.ExchangeInfo.t() | nil,
          receiver: ForgeAbi.ExchangeInfo.t() | nil,
          expired_at: Google.Protobuf.Timestamp.t() | nil,
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:to, :sender, :receiver, :expired_at, :data]

  field :to, 1, type: :string
  field :sender, 2, type: ForgeAbi.ExchangeInfo
  field :receiver, 3, type: ForgeAbi.ExchangeInfo
  field :expired_at, 4, type: Google.Protobuf.Timestamp
  field :data, 15, type: Google.Protobuf.Any
end

defmodule ForgeAbi.TransferTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          to: String.t(),
          value: ForgeAbi.BigUint.t() | nil,
          assets: [String.t()],
          data: Google.Protobuf.Any.t() | nil
        }
  defstruct [:to, :value, :assets, :data]

  field :to, 1, type: :string
  field :value, 2, type: ForgeAbi.BigUint
  field :assets, 3, repeated: true, type: :string
  field :data, 15, type: Google.Protobuf.Any
end
