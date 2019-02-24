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
