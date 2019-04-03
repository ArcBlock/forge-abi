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
