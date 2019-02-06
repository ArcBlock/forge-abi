defmodule ForgeAbiTest.Util.TypeUrl do
  @moduledoc false
  use ExUnit.Case

  alias ForgeAbi.Util.TypeUrl
  alias ForgeAbi.AccountState
  alias Google.Protobuf.Any

  @mod ForgeAbiTest.Util.TypeUrl
  test "add items to type url could be retrieved" do
    type_urls = [
      {:t1, "t1", @mod},
      {:t2, "t2", @mod}
    ]

    assert :ok = TypeUrl.extend(type_urls)

    all = TypeUrl.all()

    assert {:t1, "t1", @mod} in all
    assert {:t2, "t2", @mod} in all
    assert {"t1", @mod} = TypeUrl.get(:t1)
    assert {"t2", @mod} = TypeUrl.get(:t2)
    assert {:t1, @mod} = TypeUrl.get("t1")
    assert {:t2, @mod} = TypeUrl.get("t2")

    assert {:error, "Unknown type unknown_transaction"} = TypeUrl.get(:unknown_transaction)
    assert {:error, "Unknown type unknown_transaction"} = TypeUrl.get("unknown_transaction")
  end

  test "remove items shall work" do
    type_urls = [
      {:t1, "t1", @mod},
      {:t2, "t2", @mod}
    ]

    assert :ok = TypeUrl.extend(type_urls)
    assert :ok = TypeUrl.remove(:t1)
    assert :ok = TypeUrl.remove(:unknown_transaction)

    all = TypeUrl.all()

    assert {:t1, "t1", @mod} not in all
    assert {:t2, "t2", @mod} in all
    assert {:error, "Unknown type t1"} = TypeUrl.get(:t1)
    assert {"t2", @mod} = TypeUrl.get(:t2)
    assert {:error, "Unknown type t1"} = TypeUrl.get("t1")
    assert {:t2, @mod} = TypeUrl.get("t2")
  end

  test "encode items shall work" do
    type_urls = [
      {:account_state, "fg:s:account_state", AccountState}
    ]

    assert :ok = TypeUrl.extend(type_urls)

    expected_state = AccountState.new(nonce: 2, num_txs: 3, address: "1234abcd")

    expected_any =
      Any.new(type_url: "fg:s:account_state", value: AccountState.encode(expected_state))

    assert {:ok, expected_any} == TypeUrl.encode(:account_state, expected_state)
  end

  test "decode items shall work" do
    type_urls = [
      {:account_state, "fg:s:account_state", AccountState}
    ]

    assert :ok = TypeUrl.extend(type_urls)

    expected_state = AccountState.new(nonce: 2, num_txs: 3, address: "1234abcd")

    assert {:account_state, expected_state} ==
             TypeUrl.decode(
               Any.new(
                 type_url: "fg:s:account_state",
                 value: AccountState.encode(expected_state)
               )
             )
  end

  test "encode unknown item shall work" do
    type_urls = [
      {:account_state, "fg:s:account_state", AccountState}
    ]

    assert :ok = TypeUrl.extend(type_urls)

    state = AccountState.new(nonce: 2, num_txs: 3, address: "1234abcd")

    assert {:error, "Unknown type unknown_type"} == TypeUrl.encode(:unknown_type, state)
  end

  test "decode unknown item shall work" do
    any = Any.new(type_url: "any:unknown_type", value: "1234567890")
    assert {:error, "Unknown type any:unknown_type"} == TypeUrl.decode(any)
  end
end
