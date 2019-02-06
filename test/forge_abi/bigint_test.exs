defmodule ForgeAbiTest.Util.BigInt do
  @moduledoc false
  use ExUnit.Case

  import ForgeAbi.Util.BigInt
  import Kernel, except: [+: 2, -: 2]

  test "plus two BigInt should return a BigInt with sum of two original values" do
    a = 1234
    b = 1_200_000_000_000_000_000_001_234
    c = biguint(a) + biguint(b)
    assert :binary.decode_unsigned(c.value) === a + b
  end

  test "substract two BigInt should return a BigInt with substraction of two original values" do
    a = 10_000_000_000_000_000_000_000_000_009_876
    b = 9_000_000_000_000_000_000_099_999_991_234
    c = biguint(a) - biguint(b)
    assert :binary.decode_unsigned(c.value) === a - b
  end

  test "substract two BigInt, if a < b, then return 0" do
    a = 10_000_000_000_000_000_000_000_000_009_876
    b = 19_000_000_000_000_000_000_099_999_991_234
    c = biguint(a) - biguint(b)
    assert :binary.decode_unsigned(c.value) === 0
  end

  test "plus big uint and big sint with sum of two original values" do
    a = 10_000_000_000_000_000_000_000_000_009_876
    b = -1_200_000_000_000_000_000_001_234
    c = biguint(a) + bigsint(b)
    assert :binary.decode_unsigned(c.value) === a + b
  end

  test "plus big sint and big uint with sum of two original values" do
    a = -1_200_000_000_000_000_000_001_234
    b = 10_000_000_000_000_000_000_000_000_009_876
    c = bigsint(a) + biguint(b)
    assert :binary.decode_unsigned(c.value) === a + b
  end

  test "plus big sint and big sint would return 0" do
    a = -1_200_000_000_000_000_000_001_234
    b = -10_000_000_000_000_000_000_000_000_009_876
    c = bigsint(a) + bigsint(b)
    assert :binary.decode_unsigned(c.value) === 0
  end

  test "plus big sint and big uint (smaller) would return 0" do
    a = -1_200_000_000_000_000_000_001_234
    b = 10_000_000_000_000_000
    c = bigsint(a) + biguint(b)
    assert :binary.decode_unsigned(c.value) === 0
  end

  test "substract big uint by big sint should return a BigInt with substraction of two original values" do
    a = 10_000_000_000_000_000_000_000_000_009_876
    b = -9_000_000_000_000_000_000_099_999_991_234
    c = biguint(a) - bigsint(b)
    assert :binary.decode_unsigned(c.value) === a - b
  end

  test "substract big sint with anything should return 0" do
    a = -10_000_000_000_000_000_000_000_000_009_876
    b = 19_000_000_000_000_000_000_099_999_991_234
    c = bigsint(a) - biguint(b)
    assert :binary.decode_unsigned(c.value) === 0
  end

  test "add big sint/uint with nil should return itself" do
    a = -10_000_000_000_000_000_000_000_000_009_876

    c = bigsint(a) + nil
    assert :binary.decode_unsigned(c.value) === abs(a)

    a = 10_000_000_000_000_000_000_000_000_009_876
    c = biguint(a) + nil
    assert :binary.decode_unsigned(c.value) === a
  end

  test "sbustract big sint/uint with nil should return itself" do
    a = -10_000_000_000_000_000_000_000_000_009_876

    c = bigsint(a) - nil
    assert :binary.decode_unsigned(c.value) === abs(a)

    a = 10_000_000_000_000_000_000_000_000_009_876
    c = biguint(a) - nil
    assert :binary.decode_unsigned(c.value) === a
  end
end
