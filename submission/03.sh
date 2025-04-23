# Which tx in block 216,351 spends the coinbase output of block 216,128?

COINBASE_BLOCK_HASH=$(bitcoin-cli -signet getblockhash 216128)

COINBASE_TX=$(bitcoin-cli -signet getblock $COINBASE_BLOCK_HASH | jq -r '.tx[0]')


SPEND_BLOCK_HASH=$(bitcoin-cli -signet getblockhash 216351)
SPEND_BLOCK_TXS=$(bitcoin-cli -signet getblock $SPEND_BLOCK_HASH | jq -r '.tx[]')


for SPEND_TX in $SPEND_BLOCK_TXS; do 
    RAW_TX=$(bitcoin-cli -signet getrawtransaction $SPEND_TX 1)
    
    SPEND_COINBASE=$(echo "$RAW_TX" | jq -r --arg COINBASE "$COINBASE_TX" '.vin[] | select(.txid == $COINBASE) | "true"')

    if [ ! -z "$SPEND_COINBASE" ]; then 
        echo $SPEND_TX
        exit 0
    fi
done

