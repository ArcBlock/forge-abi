defmodule ForgeAbi do
  @moduledoc """
  Public interface for ForgeAbi
  """
  alias ForgeAbi.Util.TypeUrl

  # typeurl related
  defdelegate add_type_url(type_url, mod), to: TypeUrl, as: :add
  defdelegate add_type_urls(type_urls), to: TypeUrl, as: :add
  defdelegate remove_type_url(type_url), to: TypeUrl, as: :remove
  defdelegate get_type_url(v), to: TypeUrl, as: :get
  defdelegate get_type_urls, to: TypeUrl, as: :all
  defdelegate get_urls, to: TypeUrl, as: :all_urls

  defdelegate encode_any(data, type_url \\ nil), to: TypeUrl
  defdelegate encode_any!(data, type_url \\ nil), to: TypeUrl
  defdelegate decode_any(any), to: TypeUrl
  defdelegate decode_any!(any), to: TypeUrl

  # unit related
  defdelegate one_token(decimal \\ 0), to: ForgeAbi.Unit
  defdelegate token_to_unit(num, decimal \\ 0), to: ForgeAbi.Unit
  defdelegate unit_to_token(unit, decimal \\ 0), to: ForgeAbi.Unit
end
