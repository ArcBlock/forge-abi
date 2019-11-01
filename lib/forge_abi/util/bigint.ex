defmodule ForgeAbi.Util.BigInt do
  @moduledoc """
  Big int operators. Note that at the moment we only need `:+` and `:-`.
  As for `==`, `!=`, `>`, `>=`, `<`, `<=` the default behavior is as expected so
  we won't override them.
  """
  import Kernel, except: [+: 2, -: 2, >=: 2, >: 2, <=: 2, <: 2]
  alias ForgeAbi.{BigSint, BigUint}

  @doc false
  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [+: 2, -: 2, >=: 2, >: 2, <=: 2, <: 2]
      import ForgeAbi.Util.BigInt
      alias ForgeAbi.{BigSint, BigUint}
    end
  end

  @doc """
  Create a `ForgeAbi.BigUint`.

    iex> use ForgeAbi.Util.BigInt
    iex> biguint(1234)
    %ForgeAbi.BigUint{value: <<4, 210>>}
    iex> biguint(1111111111111111111111111111111111111111)
    %ForgeAbi.BigUint{value: <<3, 67, 232, 55, 78, 152, 132, 21, 75, 248, 55, 181, 113, 199, 28, 113, 199>>}
  """
  @spec biguint(integer() | nil) :: BigUint.t()
  def biguint(nil), do: nil
  def biguint(i) when Kernel.<(i, 0), do: BigUint.new(value: <<0>>)
  def biguint(i), do: BigUint.new(value: to_binary(i))

  @doc """
  Convert BigInt to integer

    iex> use ForgeAbi.Util.BigInt
    iex> to_int(biguint(1)) === 1
    true
    iex> to_int(bigsint(1)) === 1
    true
    iex> to_int(bigsint(-1)) === 1
    false
  """
  @spec to_int(BigUint.t() | BigSint.t() | integer() | nil) :: integer()
  def to_int(nil), do: 0
  def to_int(i) when is_integer(i), do: i
  def to_int(%BigSint{} = v), do: sign(v.minus) * to_unsigned(v.value)
  def to_int(%BigUint{} = v), do: to_unsigned(v.value)

  @doc """
  Create a `ForgeAbi.BigSint`.

    iex> use ForgeAbi.Util.BigInt
    iex> bigsint(1234)
    %ForgeAbi.BigSint{value: <<4, 210>>, minus: false}
    iex> bigsint(-1234)
    %ForgeAbi.BigSint{value: <<4, 210>>, minus: true}
    iex> bigsint(-1111111111111111111111111111111111111111)
    %ForgeAbi.BigSint{value: <<3, 67, 232, 55, 78, 152, 132, 21, 75, 248, 55, 181, 113, 199, 28, 113, 199>>, minus: true}
  """
  @spec bigsint(integer()) :: BigSint.t()
  def bigsint(i) when Kernel.<(i, 0), do: BigSint.new(value: to_binary(abs(i)), minus: true)
  def bigsint(i), do: BigSint.new(value: to_binary(i))

  @doc """
  Convert a sint to uint

    iex> use ForgeAbi.Util.BigInt
    iex> to_uint(bigsint(-1234))
    %ForgeAbi.BigUint{value: <<4, 210>>}
    iex> to_uint(biguint(1234))
    %ForgeAbi.BigUint{value: <<4, 210>>}
  """
  @spec to_uint(BigUint.t() | BigSint.t() | nil) :: BigUint.t()
  def to_uint(nil), do: biguint(0)
  def to_uint(v), do: BigUint.new(value: v.value)

  @doc """
  Convert a uint to sint

    iex> use ForgeAbi.Util.BigInt
    iex> to_sint(bigsint(-1234))
    %ForgeAbi.BigSint{value: <<4, 210>>, minus: true}
    iex> to_sint(biguint(1234))
    %ForgeAbi.BigSint{value: <<4, 210>>, minus: false}
  """
  @spec to_sint(BigUint.t() | BigSint.t()) :: BigSint.t()
  def to_sint(%BigSint{} = v), do: v
  def to_sint(v), do: BigSint.new(value: v.value)

  @doc """
  Generate a BigSint with a regular integer

    iex> use ForgeAbi.Util.BigInt
    iex> to_unit(-1234)
    %ForgeAbi.BigSint{minus: true, value: <<171, 64, 124, 158, 176, 82, 0, 0>>}
    iex> to_unit(200)
    %ForgeAbi.BigSint{minus: false, value: <<27, 193, 109, 103, 78, 200, 0, 0>>}
  """
  @spec to_unit(integer(), non_neg_integer()) :: BigSint.t()
  def to_unit(v, decimal \\ 0), do: bigsint(v * one_token(decimal))

  @spec one_token(non_neg_integer()) :: non_neg_integer()
  def one_token(decimal \\ 0), do: decimal_to_int(decimal)

  @doc """
  Add two big int. Should return a BigUint.

    iex> use ForgeAbi.Util.BigInt
    iex> biguint(1234) + biguint(1234)
    %ForgeAbi.BigUint{value: <<9, 164>>}
  """
  @spec (BigUint.t() | BigSint.t() | number() | nil) +
          (BigUint.t() | BigSint.t() | number() | nil) :: BigUint.t() | number()
  def (%{value: va} = a) + (%{value: vb} = b) when is_binary(va) and is_binary(vb) do
    sa = Map.get(a, :minus, false)
    sb = Map.get(b, :minus, false)
    vc = do_add(sa, sb, va, vb)
    biguint(vc)
  end

  def a + (%{value: vb} = b) when is_binary(vb) and is_integer(a) do
    bigsint(a) + b
  end

  def (%{value: va} = a) + b when is_binary(va) and is_integer(b) do
    a + bigsint(b)
  end

  def nil + nil, do: 0
  def nil + b, do: b
  def a + nil, do: a
  def a + b, do: Kernel.+(a, b)

  @doc """
  Substract two big int. Should return a BigUint.

    iex> use ForgeAbi.Util.BigInt
    iex> biguint(1234) - biguint(1233)
    %ForgeAbi.BigUint{value: <<1>>}
    iex> biguint(1234) - biguint(1235)
    %ForgeAbi.BigUint{value: <<0>>}
    iex> biguint(1234) - bigsint(-1235)
    %ForgeAbi.BigUint{value: <<9, 165>>}
    iex> bigsint(-1234) - biguint(1235)
    %ForgeAbi.BigUint{value: <<0>>}
  """
  @spec (BigUint.t() | number()) - (BigUint.t() | BigSint.t() | number()) ::
          BigUint.t() | number()
  def %{value: va} - (%{value: vb} = b) when is_binary(va) and is_binary(vb) do
    sb = Map.get(b, :minus, false)
    vc = do_sub(sb, va, vb)
    biguint(vc)
  end

  def (%{value: va} = a) - b when is_binary(va) and is_integer(b) do
    a - bigsint(b)
  end

  def nil - nil, do: 0
  def nil - b, do: Kernel.-(0, b)
  def a - nil, do: a
  def a - b, do: Kernel.-(a, b)

  @doc """
  Compare biguint, bigsint(we just use its abs value), and normal integer/float

    iex> use ForgeAbi.Util.BigInt
    iex> biguint(1234) > biguint(1233)
    true
    iex> biguint(1234) <= biguint(1235)
    true
    iex> biguint(1234) > bigsint(-1235)
    false
    iex> bigsint(-1234) > biguint(100)
    true
    iex> bigsint(-1234) > 1000
    true
    iex> bigsint(-1234) > 2000
    false
    iex> 1000 >= biguint(999)
    true
    iex> 1000 >= biguint(1001)
    false
  """

  def a >= b, do: Kernel.>=(to_unsigned(a), to_unsigned(b))
  def a > b, do: Kernel.>(to_unsigned(a), to_unsigned(b))
  def a <= b, do: Kernel.<=(to_unsigned(a), to_unsigned(b))
  def a < b, do: Kernel.<(to_unsigned(a), to_unsigned(b))

  # private function
  defp sign(false), do: 1
  defp sign(true), do: -1

  defp to_binary(i), do: :binary.encode_unsigned(i)

  defp to_unsigned(nil), do: 0
  defp to_unsigned(v) when is_integer(v), do: v
  defp to_unsigned(v) when is_float(v), do: v
  defp to_unsigned(%{value: a}), do: to_unsigned(a)
  defp to_unsigned(v), do: :binary.decode_unsigned(v)

  defp do_add(false, false, va, vb), do: to_unsigned(va) + to_unsigned(vb)
  defp do_add(false, true, va, vb), do: to_unsigned(va) - to_unsigned(vb)
  defp do_add(true, false, va, vb), do: to_unsigned(vb) - to_unsigned(va)
  defp do_add(true, true, _va, _vb), do: 0

  defp do_sub(false, va, vb), do: to_unsigned(va) - to_unsigned(vb)
  defp do_sub(true, va, vb), do: to_unsigned(va) + to_unsigned(vb)

  defp decimal_to_int(0) do
    decimal = Application.get_env(:forge_abi, :decimal)
    round(:math.pow(10, decimal))
  end

  defp decimal_to_int(d), do: round(:math.pow(10, d))
end
