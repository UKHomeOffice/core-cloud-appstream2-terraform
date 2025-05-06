#!/bin/bash

# Variables
FLEET_NAME=$1
REGION=$2
MAX_RETRIES=30
SLEEP_INTERVAL=30

# Poll the fleet status
for (( i=0; i<$MAX_RETRIES; i++ )); do
  FLEET_STATUS=$(aws appstream describe-fleets --name $FLEET_NAME --region $REGION --query "Fleets[0].State" --output text)

  if [ "$FLEET_STATUS" == "RUNNING" ]; then
    echo "Fleet is in RUNNING state."
    exit 0
  else
    echo "Fleet status: $FLEET_STATUS. Waiting..."
    sleep $SLEEP_INTERVAL
  fi
done

echo "Fleet did not reach RUNNING state within the timeout."
exit 1
