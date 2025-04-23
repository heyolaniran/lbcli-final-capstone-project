# How many new outputs were created by block 243,825?

HASH=$(bitcoin-cli -signet getblockhash 243825)
BLOCK=$(bitcoin-cli -signet getblock $HASH 2)

INPUTS=$(echo $BLOCK | jq -r '[.tx[].vout | length] | add')

echo $INPUTS