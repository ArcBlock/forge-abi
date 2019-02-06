defmodule ForgeAbi do
  @moduledoc """
  Public interface for ForgeAbi
  """
  alias ForgeAbi.Util.TypeUrl

  # typeurl related
  defdelegate encode_any(type, data), to: TypeUrl, as: :encode
  defdelegate encode_any!(type, data), to: TypeUrl, as: :encode!
  defdelegate decode_any(any), to: TypeUrl, as: :decode

  # arc related
  defdelegate one_token, to: ForgeAbi.Arc
  defdelegate token_to_arc(num), to: ForgeAbi.Arc
  defdelegate arc_to_token(arc), to: ForgeAbi.Arc
end
