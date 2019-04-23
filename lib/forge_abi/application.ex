defmodule ForgeAbi.Application do
  @moduledoc false

  use Application
  alias ForgeAbi.Util.TypeUrl

  def start(_type, _args) do
    TypeUrl.init()
    children = []
    opts = [strategy: :one_for_one, name: ForgeAbi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
