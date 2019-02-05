defmodule ForgeWeb.GQL.Schema.Forge do
  @moduledoc "GraphQL Schema for forge"
  alias(Absinthe.Plugin)
  use(Absinthe.Schema)
  import_types(Absinthe.Plug.Types)
  import_types(Absinthe.Type.Custom)
  import_types(ForgeWeb.GQL.Notation.Forge)
  require(Logger)
  alias(ForgeWeb.GQL.Forge.Resolver)

  def plugins do
    Plugin.defaults()
  end

  query do
    @desc ""
    field(:multisig, :response_multisig) do
      @desc ""
      arg(:token, :string)

      @desc ""
      arg(:tx, :string)

      @desc ""
      arg(:wallet, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :multisig)
        apply(Resolver, :multisig, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:get_tx, :response_get_tx) do
      @desc ""
      arg(:hash, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :get_tx)
        apply(Resolver, :get_tx, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:get_block, :response_get_block) do
      @desc ""
      arg(:height, :integer)

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :get_block)
        apply(Resolver, :get_block, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:get_blocks, :response_get_blocks) do
      @desc ""
      arg(:max_height, :integer)

      @desc ""
      arg(:min_height, :integer)

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :get_blocks)
        apply(Resolver, :get_blocks, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:get_unconfirmed_txs, :response_get_unconfirmed_txs) do
      @desc ""
      arg(:limit, :integer)

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :get_unconfirmed_txs)
        apply(Resolver, :get_unconfirmed_txs, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:get_chain_info, :response_get_chain_info) do
      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :get_chain_info)
        apply(Resolver, :get_chain_info, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:search, :response_search) do
      @desc ""
      arg(:key, :string)

      @desc ""
      arg(:value, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :search)
        apply(Resolver, :search, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:get_net_info, :response_get_net_info) do
      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :get_net_info)
        apply(Resolver, :get_net_info, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:get_validators_info, :response_get_validators_info) do
      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :get_validators_info)
        apply(Resolver, :get_validators_info, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:get_config, :response_get_config) do
      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :get_config)
        apply(Resolver, :get_config, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:load_file, :response_load_file) do
      @desc ""
      arg(:hash, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :load_file)
        apply(Resolver, :load_file, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:pin_file, :response_pin_file) do
      @desc ""
      arg(:hash, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :pin_file)
        apply(Resolver, :pin_file, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:get_account_state, :response_get_account_state) do
      @desc ""
      arg(:address, :string)

      @desc ""
      arg(:app_hash, :string)

      @desc ""
      arg(:keys, list_of(:string))

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :get_account_state)
        apply(Resolver, :get_account_state, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:get_asset_state, :response_get_asset_state) do
      @desc ""
      arg(:address, :string)

      @desc ""
      arg(:app_hash, :string)

      @desc ""
      arg(:keys, list_of(:string))

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :get_asset_state)
        apply(Resolver, :get_asset_state, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:get_stake_state, :response_get_stake_state) do
      @desc ""
      arg(:address, :string)

      @desc ""
      arg(:app_hash, :string)

      @desc ""
      arg(:keys, list_of(:string))

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :get_stake_state)
        apply(Resolver, :get_stake_state, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:get_forge_state, :response_get_forge_state) do
      @desc ""
      arg(:app_hash, :string)

      @desc ""
      arg(:keys, list_of(:string))

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :get_forge_state)
        apply(Resolver, :get_forge_state, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:load_wallet, :response_load_wallet) do
      @desc ""
      arg(:address, :string)

      @desc ""
      arg(:passphrase, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :load_wallet)
        apply(Resolver, :load_wallet, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:list_wallet, :response_list_wallet) do
      resolve(fn parent, args, resolution ->
        Logger.metadata(query: :list_wallet)
        apply(Resolver, :list_wallet, [parent, args, resolution])
      end)
    end
  end

  mutation do
    @desc ""
    field(:create_tx, :response_create_tx) do
      @desc ""
      arg(:from, :string)

      @desc ""
      arg(:itx, :string)

      @desc ""
      arg(:nonce, :integer)

      @desc ""
      arg(:token, :string)

      @desc ""
      arg(:wallet, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(mutation: :mutation_create_tx)
        apply(Resolver, :mutation_create_tx, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:send_tx, :response_send_tx) do
      @desc ""
      arg(:commit, :boolean)

      @desc ""
      arg(:token, :string)

      @desc ""
      arg(:tx, :string)

      @desc ""
      arg(:wallet, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(mutation: :mutation_send_tx)
        apply(Resolver, :mutation_send_tx, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:unsubscribe, :response_unsubscribe) do
      @desc ""
      arg(:topic, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(mutation: :mutation_unsubscribe)
        apply(Resolver, :mutation_unsubscribe, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:store_file, :response_store_file) do
      @desc ""
      arg(:chunk, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(mutation: :mutation_store_file)
        apply(Resolver, :mutation_store_file, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:create_wallet, :response_create_wallet) do
      @desc ""
      arg(:moniker, :string)

      @desc ""
      arg(:passphrase, :string)

      @desc ""
      arg(:type, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(mutation: :mutation_create_wallet)
        apply(Resolver, :mutation_create_wallet, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:recover_wallet, :response_recover_wallet) do
      @desc ""
      arg(:data, :string)

      @desc ""
      arg(:moniker, :string)

      @desc ""
      arg(:passphrase, :string)

      @desc ""
      arg(:type, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(mutation: :mutation_recover_wallet)
        apply(Resolver, :mutation_recover_wallet, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:remove_wallet, :response_remove_wallet) do
      @desc ""
      arg(:address, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(mutation: :mutation_remove_wallet)
        apply(Resolver, :mutation_remove_wallet, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:declare_node, :response_declare_node) do
      @desc ""
      arg(:validator, :boolean)

      resolve(fn parent, args, resolution ->
        Logger.metadata(mutation: :mutation_declare_node)
        apply(Resolver, :mutation_declare_node, [parent, args, resolution])
      end)
    end

    @desc ""
    field(:declare, :string) do
      @desc ""
      arg(:declare_tx, non_null(:string))

      @desc ""
      arg(:wallet, non_null(:string))

      @desc ""
      arg(:token, :string)

      @desc ""
      arg(:sign, :boolean)

      @desc ""
      arg(:send, :string)

      resolve(fn parent, args, resolution ->
        Logger.metadata(mutation: :mutation_declare)
        apply(Resolver, :mutation_declare, [parent, args, resolution])
      end)
    end
  end

  subscription do
    @desc ""
    field(:subscribe, :response_subscribe) do
      @desc ""
      arg(:filter, :string)

      @desc ""
      arg(:type, :string)

      config(fn args, resolution ->
        Logger.metadata(subscription: :subscription_subscribe)
        apply(Resolver, :subscription_subscribe, [args, resolution])
      end)
    end
  end
end
