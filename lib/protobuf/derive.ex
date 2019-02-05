import Protocol

# we need to serialize the WalletInfo
derive(Jason.Encoder, ForgeAbi.WalletType)
derive(Jason.Encoder, ForgeAbi.WalletInfo)
