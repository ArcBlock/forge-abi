defmodule ForgeAbi.ApplicationTx do
  @moduledoc """
  Application defined transaction. We need to wrap the Any data with a container.
  Previously this was defined in ForgeTx. But it shall belong to here.
  """
  use TypedStruct

  alias Google.Protobuf.Any

  @typedoc """
  Application defined transaction. It contains keys as folows:

  * `:tx`: inner transaction
  * `:handler`: then module to handle `Forge.Handler` behavior.
  """
  typedstruct do
    field :itx, Any.t()
  end

  def new(opts \\ []), do: %ForgeAbi.ApplicationTx{itx: opts[:itx]}
end
