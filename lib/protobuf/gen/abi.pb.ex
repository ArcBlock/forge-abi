defmodule ForgeAbi.RequestVerifyTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: ForgeAbi.Transaction.t(),
          states: [ForgeAbi.AccountState.t()],
          assets: [ForgeAbi.AssetState.t()],
          stakes: [ForgeAbi.StakeState.t()],
          context: ForgeAbi.AbciContext.t(),
          app_state: ForgeAbi.ForgeState.t()
        }
  defstruct [:tx, :states, :assets, :stakes, :context, :app_state]

  field :tx, 1, type: ForgeAbi.Transaction
  field :states, 2, repeated: true, type: ForgeAbi.AccountState
  field :assets, 3, repeated: true, type: ForgeAbi.AssetState
  field :stakes, 4, repeated: true, type: ForgeAbi.StakeState
  field :context, 5, type: ForgeAbi.AbciContext
  field :app_state, 15, type: ForgeAbi.ForgeState
end

defmodule ForgeAbi.ResponseVerifyTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer
        }
  defstruct [:code]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
end

defmodule ForgeAbi.RequestUpdateState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: ForgeAbi.Transaction.t(),
          states: [ForgeAbi.AccountState.t()],
          assets: [ForgeAbi.AssetState.t()],
          stakes: [ForgeAbi.StakeState.t()],
          context: ForgeAbi.AbciContext.t(),
          app_state: ForgeAbi.ForgeState.t()
        }
  defstruct [:tx, :states, :assets, :stakes, :context, :app_state]

  field :tx, 1, type: ForgeAbi.Transaction
  field :states, 2, repeated: true, type: ForgeAbi.AccountState
  field :assets, 3, repeated: true, type: ForgeAbi.AssetState
  field :stakes, 4, repeated: true, type: ForgeAbi.StakeState
  field :context, 5, type: ForgeAbi.AbciContext
  field :app_state, 15, type: ForgeAbi.ForgeState
end

defmodule ForgeAbi.ResponseUpdateState do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: integer,
          states: [ForgeAbi.AccountState.t()],
          assets: [ForgeAbi.AssetState.t()],
          stakes: [ForgeAbi.StakeState.t()],
          app_state: ForgeAbi.ForgeState.t()
        }
  defstruct [:code, :states, :assets, :stakes, :app_state]

  field :code, 1, type: ForgeAbi.StatusCode, enum: true
  field :states, 2, repeated: true, type: ForgeAbi.AccountState
  field :assets, 3, repeated: true, type: ForgeAbi.AssetState
  field :stakes, 4, repeated: true, type: ForgeAbi.StakeState
  field :app_state, 15, type: ForgeAbi.ForgeState
end

defmodule ForgeAbi.RequestInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          forge_version: String.t()
        }
  defstruct [:forge_version]

  field :forge_version, 1, type: :string
end

defmodule ForgeAbi.ResponseInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type_urls: [String.t()]
        }
  defstruct [:type_urls]

  field :type_urls, 1, repeated: true, type: :string
end

defmodule ForgeAbi.Request do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof :value, 0
  field :verify_tx, 1, type: ForgeAbi.RequestVerifyTx, oneof: 0
  field :update_state, 2, type: ForgeAbi.RequestUpdateState, oneof: 0
  field :info, 3, type: ForgeAbi.RequestInfo, oneof: 0
end

defmodule ForgeAbi.Response do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof :value, 0
  field :verify_tx, 1, type: ForgeAbi.ResponseVerifyTx, oneof: 0
  field :update_state, 2, type: ForgeAbi.ResponseUpdateState, oneof: 0
  field :info, 3, type: ForgeAbi.ResponseInfo, oneof: 0
end

defmodule ForgeAbi.ForgeAppRpc.Service do
  @moduledoc false
  use GRPC.Service, name: "forge_abi.ForgeAppRpc"

  rpc :process_one, ForgeAbi.Request, ForgeAbi.Response
  rpc :process, stream(ForgeAbi.Request), stream(ForgeAbi.Response)
end

defmodule ForgeAbi.ForgeAppRpc.Stub do
  @moduledoc false
  use GRPC.Stub, service: ForgeAbi.ForgeAppRpc.Service
end
