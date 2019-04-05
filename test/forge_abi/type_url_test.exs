defmodule ForgeAbiTest.Util.TypeUrl do
  @moduledoc false
  use ExUnit.Case

  alias ForgeAbi.Util.TypeUrl
  alias ForgeAbi.AccountState
  alias Google.Protobuf.Any

  @mod1 ForgeAbiTest.Util.TypeUrl
  @mod2 Google.Protobuf.Any
  test "add items to type url could be retrieved" do
    type_urls = [
      {"t1", @mod1},
      {"t2", @mod2}
    ]

    assert :ok = TypeUrl.add(type_urls)

    all = Enum.into(TypeUrl.all(), [])

    assert {"t1", @mod1} in all
    assert {"t2", @mod2} in all
    assert @mod1 == TypeUrl.get("t1")
    assert @mod2 == TypeUrl.get("t2")
    assert "t1" == TypeUrl.get(@mod1)
    assert "t2" == TypeUrl.get(@mod2)

    assert nil == TypeUrl.get("unknown_transaction")
    assert nil == TypeUrl.get(Google.Protobuf)
  end

  test "remove items shall work" do
    type_urls = [
      {"t1", @mod1},
      {"t2", @mod2}
    ]

    assert :ok == TypeUrl.add(type_urls)
    assert :ok == TypeUrl.remove("t1")
    assert :ok == TypeUrl.remove("t3")

    all = Enum.into(TypeUrl.all(), [])

    assert {"t1", @mod1} not in all
    assert {"t2", @mod2} in all
    assert nil == TypeUrl.get("t1")
    assert @mod2 == TypeUrl.get("t2")
  end

  test "encode items shall work" do
    type_urls = [
      {"fg:s:account_state", AccountState}
    ]

    assert :ok = TypeUrl.add(type_urls)

    expected_state = AccountState.new(nonce: 2, num_txs: 3, address: "1234abcd")

    expected_any =
      Any.new(type_url: "fg:s:account_state", value: AccountState.encode(expected_state))

    assert {:ok, expected_any} == TypeUrl.encode(expected_state)
  end

  test "decode items shall work" do
    type_urls = [
      {"fg:s:account_state", AccountState}
    ]

    assert :ok = TypeUrl.add(type_urls)

    expected_state = AccountState.new(nonce: 2, num_txs: 3, address: "1234abcd")

    assert {:ok, expected_state} ==
             TypeUrl.decode(
               Any.new(
                 type_url: "fg:s:account_state",
                 value: AccountState.encode(expected_state)
               )
             )
  end

  test "encode unknown item shall work" do
    state = %{a: 1, __module__: Hello}

    assert {:error, :invalid_data} == TypeUrl.encode(state)
  end

  test "decode unknown item shall work" do
    any = Any.new(type_url: "any:unknown_type", value: "1234567890")
    assert {:error, :noent} == TypeUrl.decode(any)
  end
end
