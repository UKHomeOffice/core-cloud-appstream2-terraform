#!/usr/bin/env bash
set -euo pipefail

# Debugging (remove once things are stable)
echo "PATH=$PATH"
echo "AWS CLI: $(which aws) $(aws --version)"

FLEET_NAME="$1"
REGION="$2"
MAX_RETRIES=30
SLEEP_INTERVAL=30

echo "Checking AppStream fleet status for '$FLEET_NAME' in region '$REGION'"

for (( i=1; i<=MAX_RETRIES; i++ )); do
  FLEET_STATUS=$(aws appstream describe-fleets \
    --names "$FLEET_NAME" \
    --region "$REGION" \
    --query 'Fleets[0].State' \
    --output text || echo "")

  if [[ "$FLEET_STATUS" == "RUNNING" ]]; then
    echo "✔ Fleet '$FLEET_NAME' is RUNNING."
    exit 0
  fi

  echo "[$i/$MAX_RETRIES] Fleet status: '${FLEET_STATUS:-UNKNOWN}'. Waiting $SLEEP_INTERVAL seconds..."
  sleep "$SLEEP_INTERVAL"
done

echo "✖ Fleet '$FLEET_NAME' did not reach RUNNING state after $(( MAX_RETRIES * SLEEP_INTERVAL )) seconds." >&2
exit 1
