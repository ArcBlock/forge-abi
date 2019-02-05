defmodule ForgeAbi.ChainRpc.Service do
  @moduledoc false
  use GRPC.Service, name: "forge_abi.ChainRpc"

  rpc :create_tx, ForgeAbi.RequestCreateTx, ForgeAbi.ResponseCreateTx
  rpc :multisig, ForgeAbi.RequestMultisig, ForgeAbi.ResponseMultisig
  rpc :send_tx, ForgeAbi.RequestSendTx, ForgeAbi.ResponseSendTx
  rpc :get_tx, stream(ForgeAbi.RequestGetTx), stream(ForgeAbi.ResponseGetTx)
  rpc :get_block, stream(ForgeAbi.RequestGetBlock), stream(ForgeAbi.ResponseGetBlock)
  rpc :get_blocks, ForgeAbi.RequestGetBlocks, ForgeAbi.ResponseGetBlocks
  rpc :get_unconfirmed_txs, ForgeAbi.RequestGetUnconfirmedTxs, ForgeAbi.ResponseGetUnconfirmedTxs
  rpc :get_chain_info, ForgeAbi.RequestGetChainInfo, ForgeAbi.ResponseGetChainInfo
  rpc :search, ForgeAbi.RequestSearch, ForgeAbi.ResponseSearch
  rpc :get_net_info, ForgeAbi.RequestGetNetInfo, ForgeAbi.ResponseGetNetInfo
  rpc :get_validators_info, ForgeAbi.RequestGetValidatorsInfo, ForgeAbi.ResponseGetValidatorsInfo
  rpc :get_config, ForgeAbi.RequestGetConfig, ForgeAbi.ResponseGetConfig
end

defmodule ForgeAbi.ChainRpc.Stub do
  @moduledoc false
  use GRPC.Stub, service: ForgeAbi.ChainRpc.Service
end

defmodule ForgeAbi.EventRpc.Service do
  @moduledoc false
  use GRPC.Service, name: "forge_abi.EventRpc"

  rpc :subscribe, ForgeAbi.RequestSubscribe, stream(ForgeAbi.ResponseSubscribe)
  rpc :unsubscribe, ForgeAbi.RequestUnsubscribe, ForgeAbi.ResponseUnsubscribe
end

defmodule ForgeAbi.EventRpc.Stub do
  @moduledoc false
  use GRPC.Stub, service: ForgeAbi.EventRpc.Service
end

defmodule ForgeAbi.FileRpc.Service do
  @moduledoc false
  use GRPC.Service, name: "forge_abi.FileRpc"

  rpc :store_file, stream(ForgeAbi.RequestStoreFile), ForgeAbi.ResponseStoreFile
  rpc :load_file, ForgeAbi.RequestLoadFile, stream(ForgeAbi.ResponseLoadFile)
  rpc :pin_file, ForgeAbi.RequestPinFile, ForgeAbi.ResponsePinFile
end

defmodule ForgeAbi.FileRpc.Stub do
  @moduledoc false
  use GRPC.Stub, service: ForgeAbi.FileRpc.Service
end

defmodule ForgeAbi.StateRpc.Service do
  @moduledoc false
  use GRPC.Service, name: "forge_abi.StateRpc"

  rpc :get_account_state,
      stream(ForgeAbi.RequestGetAccountState),
      stream(ForgeAbi.ResponseGetAccountState)

  rpc :get_asset_state,
      stream(ForgeAbi.RequestGetAssetState),
      stream(ForgeAbi.ResponseGetAssetState)

  rpc :get_stake_state,
      stream(ForgeAbi.RequestGetStakeState),
      stream(ForgeAbi.ResponseGetStakeState)

  rpc :get_forge_state, ForgeAbi.RequestGetForgeState, ForgeAbi.ResponseGetForgeState
end

defmodule ForgeAbi.StateRpc.Stub do
  @moduledoc false
  use GRPC.Stub, service: ForgeAbi.StateRpc.Service
end

defmodule ForgeAbi.WalletRpc.Service do
  @moduledoc false
  use GRPC.Service, name: "forge_abi.WalletRpc"

  rpc :create_wallet, ForgeAbi.RequestCreateWallet, ForgeAbi.ResponseCreateWallet
  rpc :load_wallet, ForgeAbi.RequestLoadWallet, ForgeAbi.ResponseLoadWallet
  rpc :recover_wallet, ForgeAbi.RequestRecoverWallet, ForgeAbi.ResponseRecoverWallet
  rpc :list_wallet, ForgeAbi.RequestListWallet, stream(ForgeAbi.ResponseListWallet)
  rpc :remove_wallet, ForgeAbi.RequestRemoveWallet, ForgeAbi.ResponseRemoveWallet
  rpc :declare_node, ForgeAbi.RequestDeclareNode, ForgeAbi.ResponseDeclareNode
end

defmodule ForgeAbi.WalletRpc.Stub do
  @moduledoc false
  use GRPC.Stub, service: ForgeAbi.WalletRpc.Service
end
