# what block height was this tx mined ?
TX=49990a9c8e60c8cba979ece134124695ffb270a98ba39c9824e42c4dc227c7eb

BLOCKHASH=$(bitcoin-cli -signet getrawtransaction $TX 1| jq -r '.blockhash')

BLOCKHEIGHT=$(bitcoin-cli -signet getblock $BLOCKHASH | jq -r '.height')

echo $BLOCKHEIGHT