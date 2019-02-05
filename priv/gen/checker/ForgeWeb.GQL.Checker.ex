defmodule ForgeWeb.GQL.Checker do
  @moduledoc false
  require(Logger)

  def valid? do
    Enum.all?([:forge], fn name -> apply(ForgeWeb.GQL.Checker, name, []) end)
  end

  def forge() do
    Enum.all?(
      [
        :multisig,
        :get_tx,
        :get_block,
        :get_blocks,
        :get_unconfirmed_txs,
        :get_chain_info,
        :search,
        :get_net_info,
        :get_validators_info,
        :get_config,
        :load_file,
        :pin_file,
        :get_account_state,
        :get_asset_state,
        :get_stake_state,
        :get_forge_state,
        :load_wallet,
        :list_wallet,
        :mutation_create_tx,
        :mutation_send_tx,
        :mutation_unsubscribe,
        :mutation_store_file,
        :mutation_create_wallet,
        :mutation_recover_wallet,
        :mutation_remove_wallet,
        :mutation_declare_node,
        :mutation_declare,
        :subscription_subscribe,
        :subscribe_trigger
      ],
      fn fun ->
        case Code.ensure_compiled?(ForgeWeb.GQL.Forge.Resolver) and
               Keyword.has_key?(ForgeWeb.GQL.Forge.Resolver.__info__(:functions), fun) do
          true ->
            true

          _ ->
            Logger.error(
              "Please make sure you defined #{ForgeWeb.GQL.Forge.Resolver} and #{inspect(fun)} inside it. You can refer to generated source code: `#{
                "ForgeWeb.GQL.Forge.Resolver"
              }.ex` to see how things are defined."
            )

            false
        end
      end
    )
  end
end
