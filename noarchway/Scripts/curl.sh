#!/bin/bash

# URL to request
URL="https://books.typersguild.com/afcc4b07-fcef-4048-81e0-f9b5857d1fcc-2600.epub"

# Arrays to store process IDs and statuses
declare -a pids

# Start 10 asynchronous curl processes
for i in {1..1000}; do
    echo "Starting request $i..."
    # Start curl in background, fail on HTTP errors (-f), silent mode (-s)
    curl -f -s "$URL" > /dev/null &
    # Save the PID of the background process
    pids[$i]=$!
done

# Counters for results
successCount=0
failedCount=0

# Wait for all background processes and gather their exit statuses
for i in {1..1000}; do
    pid=${pids[$i]}
    if wait "$pid"; then
        echo "Request $i succeeded."
        ((successCount++))
    else
        echo "Request $i failed."
        ((failedCount++))
    fi
done

# Summary of results
echo ""
if [ "$successCount" -eq 1000 ]; then
    echo "All 10 requests completed successfully."
else
    echo "$successCount out of 10 requests succeeded, $failedCount failed."
fi

