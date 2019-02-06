defmodule ForgeAbi.Arc do
  @moduledoc """
  Arc is the smallest, infungible unit used for Forge Apps. If app define decimal as 16, then
  1 token (e.g. ABT) = 10^16 arc. When sending transfer tx or exchange tx, the value shall be
  created with Arc.
  """
  alias ForgeAbi.Util.BigInt
  alias ForgeAbi.{BigUint}

  @doc false
  defmacro __using__(_opts) do
    quote do
      use ForgeAbi.Util.BigInt
      import ForgeAbi.Arc
    end
  end

  @doc """
  Convert integer to `ForgeAbi.BigUint.t`

  Examples:

    iex> use ForgeAbi.Arc
    iex> a = new_arc(10)
    %ForgeAbi.BigUint{value: <<10>>}
    iex> b = new_arc(2)
    %ForgeAbi.BigUint{value: <<2>>}
    iex> c = new_arc(-2)
    %ForgeAbi.BigUint{value: <<0>>}
    iex> a + b
    %ForgeAbi.BigUint{value: <<12>>}
    iex> a - b
    %ForgeAbi.BigUint{value: <<8>>}
    iex> b - a
    %ForgeAbi.BigUint{value: <<0>>}
    iex> a + c
    %ForgeAbi.BigUint{value: <<10>>}
  """
  @spec new_arc(integer()) :: BigUint.t()
  defdelegate new_arc(i), to: BigInt, as: :biguint

  @spec one_token(non_neg_integer()) :: non_neg_integer()
  defdelegate one_token(decimal \\ 0), to: BigInt

  @spec token_to_arc(number()) :: BigUint.t()
  def token_to_arc(n), do: new_arc(round(n * one_token()))

  @spec arc_to_token(BigUint.t() | non_neg_integer()) :: number()
  def arc_to_token(i) when is_integer(i), do: i / one_token()

  def arc_to_token(v) do
    BigInt.to_int(v) / one_token()
  end
end
