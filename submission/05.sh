# How many satoshis did this transaction pay for fee?: b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb
TX=b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb
RAW_TX=$(bitcoin-cli -signet getrawtransaction $TX true)

INPUT_SUM=0

INPUT_LENGTH=$(echo "$RAW_TX" | jq -r '.vin | length')

for (( i=0; i < $INPUT_LENGTH; i++)); do
    INPUT_TXID=$(echo $RAW_TX | jq -r ".vin[$i].txid")
    VOUT=$(echo $RAW_TX | jq -r ".vin[$i].vout")
    UTXO=$(bitcoin-cli -signet getrawtransaction $INPUT_TXID true | jq -r ".vout[$VOUT].value")
    INPUT_SUM=$(echo "$INPUT_SUM+$UTXO" | bc)
done
OUTPUT=$(echo $RAW_TX | jq -r '[.vout[].value] | add')

FEES=$(echo "$INPUT_SUM-$OUTPUT" | bc)

echo "$FEES*100000000" | bc | cut -d'.' -f 1
