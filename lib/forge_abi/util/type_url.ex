defmodule ForgeAbi.Util.TypeUrl do
  @moduledoc """
   quick convertion among type, type_url and type_mod
  """
  require Logger

  defmodule DummyCodec do
    @moduledoc false
    def encode(data), do: data
    def decode(data), do: data
  end

  defmodule JsonCodec do
    @moduledoc false
    def encode(data), do: Jason.encode!(data)
    def decode(data), do: Jason.decode!(data)
  end

  alias Google.Protobuf.Any

  @table_name :forge_abi
  @base_types [
    # forge tx
    {"fg:t:declare", ForgeAbi.DeclareTx},
    {"fg:t:deploy_protocol", ForgeAbi.DeployProtocolTx},

    # forge state
    {"fg:s:account", ForgeAbi.AccountState},
    {"fg:s:asset", ForgeAbi.AssetState},
    {"fg:s:blacklist", ForgeAbi.BlacklistState},
    {"fg:s:forge", ForgeAbi.ForgeState},
    {"fg:s:stake", ForgeAbi.StakeState},
    {"fg:s:statistics", ForgeAbi.StatisticsState},
    {"fg:s:protocol", ForgeAbi.ProtocolState},
    {"fg:s:root", ForgeAbi.RootState},
    {"fg:s:swap", ForgeAbi.SwapState},
    {"fg:s:delegate", ForgeAbi.DelegateState},
    {"fg:s:asset_factory_state", ForgeAbi.AssetFactoryState},

    # other type url
    {"fg:x:block_info", ForgeAbi.BlockInfo},
    {"fg:x:tx", ForgeAbi.Transaction},
    {"fg:x:tx_info", ForgeAbi.TransactionInfo},
    {"fg:x:tx_status", ForgeAbi.TxStatus},
    {"fg:x:withdraw_item", ForgeAbi.WithdrawItem},

    # forge tx

    # account
    {"fg:t:account_migrate", ForgeAbi.AccountMigrateTx},
    {"fg:t:declare", ForgeAbi.DeclareTx},
    {"fg:t:delegate", ForgeAbi.DelegateTx},
    {"fg:t:revoke_delegate", ForgeAbi.RevokeDelegateTx},
    {"fg:t:update_asset", ForgeAbi.UpdateAssetTx},

    # asset
    {"fg:t:acquire_asset", ForgeAbi.AcquireAssetTx},
    {"fg:t:consume_asset", ForgeAbi.ConsumeAssetTx},
    {"fg:t:create_asset", ForgeAbi.CreateAssetTx},
    {"fg:x:asset_factory", ForgeAbi.AssetFactory},

    # governance
    {"fg:t:update_consensus_params", ForgeAbi.UpdateConsensusParamsTx},
    {"fg:t:update_validator", ForgeAbi.UpdateValidatorTx},
    {"fg:t:upgrade_node", ForgeAbi.UpgradeNodeTx},

    # misc
    {"fg:t:poke", ForgeAbi.PokeTx},
    {"fg:t:refuel", ForgeAbi.RefuelTx},

    # atomic swap
    {"fg:t:retrieve_swap", ForgeAbi.RetrieveSwapTx},
    {"fg:t:revoke_swap", ForgeAbi.RevokeSwapTx},
    {"fg:t:setup_swap", ForgeAbi.SetupSwapTx},

    # token swap
    {"fg:t:approve_withdraw", ForgeAbi.ApproveWithdrawTx},
    {"fg:t:deposit_token", ForgeAbi.DepositTokenTx},
    {"fg:t:revoke_withdraw", ForgeAbi.RevokeWithdrawTx},
    {"fg:t:withdraw_token", ForgeAbi.WithdrawTokenTx},

    # trade
    {"fg:t:exchange", ForgeAbi.ExchangeTx},
    {"fg:t:transfer", ForgeAbi.TransferTx},
    # dummy codec
    {"fg:x:address", DummyCodec},
    {"fg:x:json", JsonCodec}
  ]

  @doc """
  Add a type url or a list of type urls to the table
  """
  @spec add([{String.t(), module()}]) :: :ok
  def add(items) when is_list(items), do: Enum.each(items, &add/1)

  @spec add({String.t(), module()}) :: :ok
  def add({type_url, mod}), do: add(type_url, mod)

  @spec add(String.t(), module()) :: :ok
  def add(type_url, mod) do
    :ets.insert(@table_name, {type_url, mod})
    :ets.insert(@table_name, {mod, type_url})
    :ok
  end

  @doc """
  Initialize the table with prepopulated data
  """
  @spec init() :: :ok
  def init do
    :ets.new(@table_name, [:named_table, :public, read_concurrency: true])
    add(@base_types)
  end

  @doc """
  Remove a type_url from the table
  """
  @spec remove(String.t()) :: :ok
  def remove(type_url) do
    :ets.delete(@table_name, type_url)
    :ok
  end

  @doc """
  retrieve all types for introspection.
  """
  @spec all :: Enumerable.t()
  def all do
    fn -> :ets.first(@table_name) end
    |> Stream.resource(
      fn
        :"$end_of_table" -> {:halt, nil}
        previous_key -> {[previous_key], :ets.next(@table_name, previous_key)}
      end,
      fn _ -> :ok end
    )
    |> Enum.map(fn key -> List.first(:ets.lookup(@table_name, key)) end)
  end

  @doc """
  retrieve all urls for introspection.
  """
  @spec all :: Enumerable.t()
  def all_urls do
    fn -> :ets.first(@table_name) end
    |> Stream.resource(
      fn
        :"$end_of_table" -> {:halt, nil}
        previous_key -> {[previous_key], :ets.next(@table_name, previous_key)}
      end,
      fn _ -> :ok end
    )
    |> Enum.filter(fn key -> is_binary(key) and String.starts_with?(key, "fg:t") end)
  end

  @doc """
  Retrieve mod by type_url

    iex> ForgeAbi.Util.TypeUrl.add("fg:t:declare", ForgeAbi.DeclareTx)
    iex> ForgeAbi.Util.TypeUrl.get("fg:t:declare")
    ForgeAbi.DeclareTx

    iex> ForgeAbi.Util.TypeUrl.add("fg:s:account", ForgeAbi.AccountState)
    iex> ForgeAbi.Util.TypeUrl.get("fg:s:account")
    ForgeAbi.AccountState
  """
  @spec get(String.t() | module() | nil) :: module() | String.t() | nil
  def get(nil), do: nil

  def get(key) do
    result = :ets.lookup(@table_name, key)

    case length(result) !== 1 do
      true -> nil
      _ -> result |> List.first() |> elem(1)
    end
  end

  @doc """
  Decode the binary inside the Any.
  """
  @spec decode_any(Any.t() | nil) :: {:error, term()} | {:ok, any()}
  def decode_any(nil), do: {:error, :noent}

  def decode_any(%{type_url: type_url, value: value}) do
    case get(type_url) do
      nil ->
        Logger.debug("Failed to find #{type_url}.")
        {:error, :noent}

      mod ->
        {:ok, mod.decode(value)}
    end
  rescue
    e ->
      Logger.warn("Failed to decode data: Error: #{inspect(e)}")
      {:error, :invalid_data}
  end

  @doc """
  Decode the binary inside the Any. Raise if error.
  """
  @spec decode_any!(Any.t() | nil) :: any() | no_return()
  def decode_any!(any) do
    case decode_any(any) do
      {:error, reason} -> raise reason
      {:ok, data} -> data
    end
  end

  @doc """
  Encode a struct and wrap it with Any.
  """
  @spec encode_any(map(), String.t() | nil) :: {:ok, Any.t()} | {:error, term()}
  def encode_any(data, type_url \\ nil)

  def encode_any(data, nil) do
    type = data.__struct__

    case get(type) do
      nil ->
        Logger.debug("Failed to find #{inspect(type)}.")
        {:error, :noent}

      type_url ->
        encode_any(data, type_url)
    end
  rescue
    e ->
      Logger.warn("Failed to get type_url for data: Error: #{inspect(e)}")
      {:error, :invalid_data}
  end

  def encode_any(data, type_url) do
    case get(type_url) do
      nil ->
        Logger.warn("Failed to find #{type_url}.")
        {:error, :noent}

      mod ->
        {:ok, Any.new(type_url: type_url, value: mod.encode(data))}
    end
  rescue
    e ->
      Logger.warn("Failed to encode data: Error: #{inspect(e)}")
      {:error, :invalid_data}
  end

  @doc """
  Encode a struct and wrap it with Any. Throw exception on error.
  """
  @spec encode_any!(map(), String.t() | nil) :: Any.t() | no_return()
  def encode_any!(data, type_url \\ nil) do
    case encode_any(data, type_url) do
      {:ok, result} -> result
      {:error, reason} -> raise "#{inspect(reason)}"
    end
  end
end
