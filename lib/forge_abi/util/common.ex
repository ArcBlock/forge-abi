defmodule ForgeAbi.Util do
  @moduledoc """
  Common functionality for ABI related stuff
  """

  @doc """
  Retrieve the nested default value for mod

  Examples:

    iex> ForgeAbi.Util.get_default(ForgeAbi.DelegateOpState)
    %ForgeAbi.DelegateOpState{
      balance: %ForgeAbi.BigUint{value: ""},
      balance_delta: %ForgeAbi.BigUint{value: ""},
      num_txs: 0,
      num_txs_delta: 0,
      rule: ""
    }

    iex> ForgeAbi.Util.get_default(ForgeAbi.TransactionInfo)
    %ForgeAbi.TransactionInfo{
      code: :ok,
      hash: "",
      height: 0,
      index: 0,
      tags: %AbciVendor.KVPair{key: "", value: ""},
      time: %Google.Protobuf.Timestamp{nanos: 0, seconds: 0},
      tx: %ForgeAbi.Transaction{
        chain_id: "",
        delegator: "",
        from: "",
        gas: 0,
        itx: %Google.Protobuf.Any{type_url: "", value: ""},
        nonce: 0,
        pk: "",
        signature: "",
        signatures: %ForgeAbi.Multisig{
          data: %Google.Protobuf.Any{type_url: "", value: ""},
          delegator: "",
          pk: "",
          signature: "",
          signer: ""
        }
      }
    }
  """
  def get_default(mod) do
    data = mod.new()

    data
    |> Map.from_struct()
    |> Map.keys()
    |> Enum.reduce(data, fn key, data ->
      props = data.__struct__.__message_props__
      field_mod = get_field_mod(props, key)

      case is_atom(field_mod) and Code.ensure_loaded?(field_mod) and
             Kernel.function_exported?(field_mod, :new, 0) do
        true -> Map.put(data, key, get_default(field_mod))
        _ -> data
      end
    end)
  end

  defp get_field_mod(props, key) do
    field = Map.get(props.field_props, Map.get(props.tags_map, Map.get(props.field_tags, key)))
    field.type
  end
end
