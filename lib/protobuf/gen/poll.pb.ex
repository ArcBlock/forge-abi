defmodule ForgeAbi.PollNoop do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule ForgeAbi.PollOption do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          action: {atom, any},
          description: String.t()
        }
  defstruct [:action, :description]

  oneof :action, 0
  field :description, 1, type: :string
  field :consensus_upgrade, 2, type: ForgeAbi.ConsensusUpgradeTx, oneof: 0
  field :noop, 3, type: ForgeAbi.PollNoop, oneof: 0
end

defmodule ForgeAbi.PollInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          title: String.t(),
          description: String.t(),
          start_time: Google.Protobuf.Timestamp.t(),
          end_time: Google.Protobuf.Timestamp.t(),
          execute_time: Google.Protobuf.Timestamp.t(),
          minimum_stake: non_neg_integer,
          maximum_stake: non_neg_integer,
          mininum_total_stake: non_neg_integer,
          success_criteria: String.t(),
          options: [ForgeAbi.PollOption.t()]
        }
  defstruct [
    :title,
    :description,
    :start_time,
    :end_time,
    :execute_time,
    :minimum_stake,
    :maximum_stake,
    :mininum_total_stake,
    :success_criteria,
    :options
  ]

  field :title, 1, type: :string
  field :description, 2, type: :string
  field :start_time, 3, type: Google.Protobuf.Timestamp
  field :end_time, 4, type: Google.Protobuf.Timestamp
  field :execute_time, 5, type: Google.Protobuf.Timestamp
  field :minimum_stake, 6, type: :uint64
  field :maximum_stake, 7, type: :uint64
  field :mininum_total_stake, 8, type: :uint64
  field :success_criteria, 9, type: :string
  field :options, 10, repeated: true, type: ForgeAbi.PollOption
end

defmodule ForgeAbi.VoteTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          index: non_neg_integer
        }
  defstruct [:address, :index]

  field :address, 1, type: :string
  field :index, 2, type: :uint32
end

defmodule ForgeAbi.AssetPollState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          info: ForgeAbi.PollInfo.t(),
          total_stakes: non_neg_integer,
          total_votes: non_neg_integer,
          votes_for_options: [non_neg_integer],
          winner_idx: non_neg_integer
        }
  defstruct [:info, :total_stakes, :total_votes, :votes_for_options, :winner_idx]

  field :info, 1, type: ForgeAbi.PollInfo
  field :total_stakes, 2, type: :uint64
  field :total_votes, 3, type: :uint64
  field :votes_for_options, 4, repeated: true, type: :uint64
  field :winner_idx, 5, type: :uint32
end
