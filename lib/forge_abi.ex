defmodule ForgeAbi do
  @moduledoc """
  Public interface for ForgeAbi
  """
  alias ForgeAbi.Util.TypeUrl

  # typeurl related
  defdelegate encode_any(type, data), to: TypeUrl, as: :encode
  defdelegate encode_any!(type, data), to: TypeUrl, as: :encode!
  defdelegate decode_any(any), to: TypeUrl, as: :decode
  defdelegate register_type_urls(urls), to: TypeUrl, as: :extend

  # unit related
  defdelegate one_token, to: ForgeAbi.Unit
  defdelegate token_to_unit(num), to: ForgeAbi.Unit
  defdelegate unit_to_token(unit), to: ForgeAbi.Unit
end
