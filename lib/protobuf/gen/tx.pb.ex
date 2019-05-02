defmodule ForgeAbi.CodeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          checksum: String.t(),
          binary: String.t()
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
          data: Google.Protobuf.Any.t()
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
