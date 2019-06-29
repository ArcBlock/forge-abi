# Status Code

## insufficient_funds

### default

the sender has no enough tokens to send tx

### stake

the stake state has no enough tokens to ...
Normally this is due to ...
check the balance by `get_stake_state(<your_stake_address>)` for more information.


## invalid_nonce

the transaction has been seen in the chain. So this is being treated as a replay tx.

