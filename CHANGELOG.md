## 1.8.2 (May 27, 2019)
  - support force upgrade

## 1.8.1 (May 23, 2019)
  - Support listing tethers.

## 1.8.0 (May 17, 2019)
  - add missing parent for asset state


## 1.7.1 (May 16, 2019)
  - remove priv

## 1.7.0 (May 16, 2019)
  - add json codec
  - remove yml files

## 1.6.3 (May 13, 2019)
  - add deprecate support. (#85)

## 1.6.2 (May 08, 2019)
  - fix license

## 1.6.1 (May 07, 2019)
  - add priv folder

## 1.6.0 (May 07, 2019)
  - Add error code for withdrawing tether transaction. (#83)

## 1.5.0 (May 07, 2019)
  - Update readme (#84)
  - use lite vendor proto for js (#82)
  - makr wallet type as deprecated
  - support embedded protocols (#81)
  - Switch to tether state. (#80)
  - add invalid_request
  - Support exchange tether transaction. (#79)
  - add declare config
  - add get_protocols api (#77)
  - fix typespec
  - deprecate accountMigrate and createAsset in TransactionInfo (#74)
  - Implement deposit tether transaction. (#78)
  - fix role type (#76)
  - workaround the forge web broken
  - rollback tx type (#75)
  - use latest generated code (#73)
  - fix: move CodeInfo and TypeUrls from tx.proto to type.proto (#72)
  - remove data_version (#70)
  - temporarily make the API work (#71)
  - support deploy tx (#63)
  - support upgrade node tx (#69)
  - Apis refactoring batch 2 (#68)
  - deprecate graqhql apis and fields (#67)
  - Rename the 'value' filed of Google.Protobuf.Any to 'encoded_value' in GQL definition. (#65)
  - remove simulator start/stop from grpc (#66)
  - add avgBlockTime to stat apis (#64)
  - add pk field to tx (#62)
  - index invalid txs and enable tx validity filter in api  (#61)
  - fix protobuf to use 0.5.3 (0.6.x not working with forge now)
  - Add blacklist state (#57)
  - add apis to start/stop/get_status simulator (#60)
  - add-get-health-status-api (#59)

## 1.4.0 (March 25, 2019)
  - do not check state in check tx pipeline (#58)

## 1.3.0 (March 23, 2019)
  - upgrade abci proto to 0.8 (#56)
  - add validator mock location info (#55)
  - list_assets with account and list of assets returns (#54)
  - Add data field to AccountMigrateTx (#53)
  - Add data field for PokeTx. (#52)
  - Rename arc related code to token (#51)
  - update chain id type (#50)
  - Add TransactionConfig, StakeTimeoutConfig, PokeConfig to Forge State (#49)
  - add p2p address (#48)
  - Add sha2. (#47)
  - update tps related types (#46)
  - list_blocks and add tps stats (#45)
  - Add too_many_tx status code (#44)
  - improve tx_info data (#43)
  - add timeout code. (#42)
  - use more commmon status code (#41)
  - update poke info message (#40)
  - support poke tx (#39)
  - Use div for integer division instead slash (#38)
  - Add forge token in protobuf (#37)
  - batch of a better forge web (#35)
  - fix multisig issue
  - deprecate activate asset tx and support consume asset tx (#34)
  - add account recent_num_txs && list asset txs (#33)
  - use version as name for forge_version (#32)
  - listTxs with mutal dir and getNodeInfo (#31)
  - support multiple db (#30)
  - update-params-in-tx-related-apis (#29)

## 1.2.5 (February 23, 2019)
  - add more logger.
  - add last block time (#27)
  - rename to activate asset tx (#26)
  - activate is a better name for the use ticket use case. Rename it (#24)
  - add prove tx (#22)
  - add pagination get blocks (#23)
  - fix resolve create and send tx (#21)
  - support index state db related apis (#19)
  - add data field for txs (#18)
  - replace transaction with transactioninfo in blockinfo (#17)
  - add grpc for signing data with wallet and token (#16)
  - add more event topic
  - add get_asset_address grpc (#15)
  - add transaction field in indexed_transaction (#14)
  - add list transaction grpc and graphql apis (#13)

## 1.2.4 (February 13, 2019)
  - add status code in tx info (#12)
  - add tx_index in abci context (#11)
  - add transaction type url. (#10)
  - add pipes to accumulate the statistics of tx and states (#9)

## 1.2.3 (February 10, 2019)
  - add app hash in info message

## 1.2.2 (February 10, 2019)
  - added forge_app_hash in forge_state.

## 1.2.1 (February 10, 2019)
  - add address in statistics state.
  - separate get forge statistics api into three apis
  - update statistics messages

## 1.2.0 (February 08, 2019)
  - add more status code (#5)
  - add forge statistics rpcs and statistics state (#4)

## 1.1.6 (February 06, 2019)
  - add register_type_urls public interface

## 1.1.5 (February 06, 2019)
  - use ex_abci_proto

## 1.1.4 (February 05, 2019)
	- move test cases to this repo

## 1.1.3 (February 05, 2019)
  - add travis support
  - move arc / type_url to forge_abi.

## 1.1.2 (February 05, 2019)
  - add dependencies

## 1.1.1 (February 05, 2019)
  - Add the `use ForgeAbi.EnumFields` back

## 1.1.0 (February 05, 2019)
  - Initialize the forge_abi repo
