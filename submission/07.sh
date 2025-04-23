# what is the coinbase tx in this block 243,834

HASH=$(bitcoin-cli -signet getblockhash 243834)
BLOCK_COINBASE=$(bitcoin-cli -signet getblock $HASH | jq -r '.tx[0]')

echo $BLOCK_COINBASE
