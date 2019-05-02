defmodule ForgeAbi.Unit do
  @moduledoc """
  Unit is the smallest, non-fungible unit used for Forge Apps. If app define decimal as 16, then
  1 token (e.g. ABT) = 10^16 unit(e.g. arc). When sending transfer tx or exchange tx, the value shall be
  created with Unit.
  """

  alias ForgeAbi.Util.BigInt
  alias ForgeAbi.{BigUint}

  @doc false
  defmacro __using__(_opts) do
    quote do
      use ForgeAbi.Util.BigInt
      import ForgeAbi.Unit
    end
  end

  @doc """
  Convert integer to `ForgeAbi.BigUint.t()`

  Examples:

    iex> use ForgeAbi.Unit
    iex> a = new_unit(10)
    %ForgeAbi.BigUint{value: <<10>>}
    iex> b = new_unit(2)
    %ForgeAbi.BigUint{value: <<2>>}
    iex> c = new_unit(-2)
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
  @spec new_unit(integer()) :: BigUint.t()
  defdelegate new_unit(i), to: BigInt, as: :biguint

  @spec one_token(non_neg_integer()) :: non_neg_integer()
  defdelegate one_token(decimal \\ 0), to: BigInt

  @spec token_to_unit(number()) :: BigUint.t()
  def token_to_unit(n), do: new_unit(round(n * one_token()))

  @spec unit_to_token(BigUint.t() | non_neg_integer()) :: number()
  def unit_to_token(i) when is_integer(i), do: div(i, one_token())

  def unit_to_token(v) do
    div(BigInt.to_int(v), one_token())
  end
end
