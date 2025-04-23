# Only one tx in block 243,821 signals opt-in RBF. What is its txid?

HASH=$(bitcoin-cli -signet getblockhash 243821)

BLOCK=$(bitcoin-cli -signet getblock $HASH 2)

OUTPUT=$(echo $BLOCK | jq -r '.tx[] | select(.vin[].sequence <= 4294967293) | .txid')

echo $OUTPUT