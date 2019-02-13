defmodule ForgeAbi.Util.TypeUrl do
  @moduledoc """
  quick convertion among type, type_url and type_mod
  """
  defmodule DummyCodec do
    @moduledoc false
    def encode(data), do: data
    def decode(data), do: data
  end

  use GenServer

  require Logger

  # tx
  alias ForgeAbi.{
    AccountMigrateTx,
    ConsensusUpgradeTx,
    CreateAssetTx,
    DeclareFileTx,
    DeclareTx,
    ExchangeTx,
    StakeTx,
    SysUpgradeTx,
    TransferTx,
    UpdateAssetTx
  }

  # state
  alias ForgeAbi.{
    AccountState,
    AssetState,
    ForgeState,
    StakeState,
    StatisticsState
  }

  # stake
  alias ForgeAbi.{
    StakeForAsset,
    StakeForChain,
    StakeForNode,
    StakeForUser
  }

  # other
  alias ForgeAbi.{
    Transaction,
    TransactionInfo,
    TxStatus
  }

  alias Google.Protobuf.Any

  @base_types [
    # forge tx
    {:account_migrate, "fg:t:account_migrate", AccountMigrateTx},
    {:create_asset, "fg:t:create_asset", CreateAssetTx},
    {:consensus_upgrade, "fg:t:consensus_upgrade", ConsensusUpgradeTx},
    {:declare, "fg:t:declare", DeclareTx},
    {:declare_file, "fg:t:declare_file", DeclareFileTx},
    {:exchange, "fg:t:exchange", ExchangeTx},
    {:stake, "fg:t:stake", StakeTx},
    {:sys_upgrade, "fg:t:sys_upgrade", SysUpgradeTx},
    {:transfer, "fg:t:transfer", TransferTx},
    {:update_asset, "fg:t:update_asset", UpdateAssetTx},

    # forge state
    {:account_state, "fg:s:account", AccountState},
    {:asset_state, "fg:s:asset", AssetState},
    {:forge_state, "fg:s:forge", ForgeState},
    {:stake_state, "fg:s:stake", StakeState},
    {:statistics_state, "fg:s:statistics", StatisticsState},

    # forge tx stake
    {:stake_for_node, "fg:x:stake_node", StakeForNode},
    {:stake_for_user, "fg:x:stake_user", StakeForUser},
    {:stake_for_asset, "fg:x:stake_asset", StakeForAsset},
    {:stake_for_chain, "fg:x:stake_chain", StakeForChain},

    # other type url
    {:transaction, "fg:x:tx", Transaction},
    {:transaction_info, "fg:x:tx_info", TransactionInfo},
    {:tx_status, "fg:x:tx_status", TxStatus},
    {:address, "fg:x:address", DummyCodec}
  ]

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @doc """
  retrieve all types for introspection.
  """
  @spec all :: [{atom(), String.t(), module()}]
  def all, do: GenServer.call(__MODULE__, :all)

  @doc """
  Retrieve tuple by type or type_url

    iex> ForgeAbi.Util.TypeUrl.get(:declare)
    {"fg:t:declare", ForgeAbi.DeclareTx}

    iex> ForgeAbi.Util.TypeUrl.get("fg:t:declare")
    {:declare, ForgeAbi.DeclareTx}

    iex> ForgeAbi.Util.TypeUrl.get(:account_state)
    {"fg:s:account", ForgeAbi.AccountState}

    iex> ForgeAbi.Util.TypeUrl.get("fg:t:transfer")
    {:transfer, ForgeAbi.TransferTx}
  """
  @spec get(atom() | String.t()) :: {atom() | String.t(), module()} | {:error, term()}
  def get(key), do: GenServer.call(__MODULE__, {:get, key})

  @spec extend([{atom(), String.t(), module()}]) :: :ok
  def extend(type_urls), do: GenServer.call(__MODULE__, {:extend, type_urls})

  @doc """
  retrieve extended types for introspection.
  """
  @spec get_extended :: [{atom(), String.t(), module()}]
  def get_extended, do: GenServer.call(__MODULE__, :get_extended)

  @spec remove(atom()) :: :ok
  def remove(type), do: GenServer.call(__MODULE__, {:remove, type})

  @doc """
  Decode the binary inside the Any.
  """
  @spec decode(Any.t() | nil) :: {:error, term()} | {atom(), any()}
  def decode(nil), do: {nil, nil}
  def decode(any), do: GenServer.call(__MODULE__, {:decode, any})

  @doc """
  Encode a struct and wrap it with Any.
  """
  @spec encode(atom(), any()) :: {:ok, Any.t()} | {:error, term()}
  def encode(type, data), do: GenServer.call(__MODULE__, {:encode, type, data})

  @doc """
  Encode a struct and wrap it with Any. Throw exception on error.
  """
  @spec encode!(atom(), any()) :: Any.t() | no_return()
  def encode!(type, data) do
    case encode(type, data) do
      {:ok, result} -> result
      {:error, reason} -> raise reason
    end
  end

  # callbacks

  def init(_) do
    # The state of this GenServer is like:
    # %{
    #   types: [
    #     {:account_state, "fg:s:ccount", AccountState},
    #     {:asset_state, "fg:s:Asset", AssetState}
    #   ],
    #   t1: %{
    #     :acount_state => {"fg:s:account", AccountState},
    #     :asset_state => {"fg:s:asset", AssetState}
    #   },
    #   t2: %{
    #     "fg:s:account" => {:account_state, AccountState}
    #     "fg:s:asset" => {asset_state, AssetState}
    #   }
    # }
    new_state = add(@base_types, %{types: [], extended: [], t1: %{}, t2: %{}})
    {:ok, new_state}
  end

  def handle_call(:all, _from, %{types: types} = state) do
    {:reply, types, state}
  end

  def handle_call(:get_extended, _from, %{extended: extended} = state) do
    {:reply, extended, state}
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, get_key(key, state), state}
  end

  def handle_call({:extend, type_urls}, _from, state) do
    new_state = add(type_urls, state, true)
    {:reply, :ok, new_state}
  end

  def handle_call({:remove, type}, _from, state) do
    new_state =
      case get_key(type, state) do
        {:error, _} -> state
        {url, _} -> remove(type, url, state)
      end

    {:reply, :ok, new_state}
  end

  def handle_call({:decode, %{type_url: type_url, value: value}}, _from, state) do
    decoded =
      case get_key(type_url, state) do
        {:error, reason} -> {:error, reason}
        {type, mod} -> {type, mod.decode(value)}
      end

    {:reply, decoded, state}
  rescue
    e ->
      Logger.warn("Failed to decode data: Error: #{inspect(e)}")
      {:reply, nil, state}
  end

  def handle_call({:encode, type, data}, _from, state) do
    encoded =
      case get_key(type, state) do
        {:error, reason} -> {:error, reason}
        {type_url, mod} -> {:ok, %Any{type_url: type_url, value: mod.encode(data)}}
      end

    {:reply, encoded, state}
  end

  def handle_call(msg, _from, state) do
    Logger.warn("Unrecognized message: #{inspect(msg)}")
    {:reply, msg, state}
  end

  # private function
  defp get_key(key, %{t1: t1}) when is_atom(key),
    do: t1 |> Map.get(key, {:error, "Unknown type #{key}"}) |> to_mod()

  defp get_key(key, %{t2: t2}) when is_binary(key),
    do: t2 |> Map.get(key, {:error, "Unknown type #{key}"}) |> to_mod()

  defp to_mod({:error, _} = error), do: error
  defp to_mod({t, m}) when is_atom(m), do: {t, m}
  defp to_mod({t, m}), do: {t, to_atom(m)}

  defp to_atom(m), do: String.to_existing_atom("Elixir." <> m)

  defp add(type_urls, state, extend? \\ false) do
    Enum.reduce(type_urls, state, fn {type, url, module} = type_url, acc ->
      %{types: types, t1: t1, t2: t2} = acc
      extended = Map.get(acc, :extended, [])

      result = %{
        acc
        | types: [type_url | types],
          t1: Map.put(t1, type, {url, module}),
          t2: Map.put(t2, url, {type, module})
      }

      case extend? do
        true -> Map.put(result, :extended, [type_url | extended])
        _ -> result
      end
    end)
  end

  defp remove(type, url, %{types: types, t1: t1, t2: t2}) do
    %{
      types: Enum.reject(types, fn {t, _, _} -> t === type end),
      t1: Map.delete(t1, type),
      t2: Map.delete(t2, url)
    }
  end
end
