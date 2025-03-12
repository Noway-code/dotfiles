#!/bin/bash
gpu_data=$(nvidia-smi --query-gpu=utilization.gpu,memory.used,memory.total,temperature.gpu,fan.speed,clocks.current.sm,pstate,power.draw,name --format=csv,noheader,nounits)
gpu_usage=$(echo "$gpu_data" | awk -F ', ' '{print $1}')
mem_used=$(echo "$gpu_data" | awk -F ', ' '{print $2}')
mem_total=$(echo "$gpu_data" | awk -F ', ' '{print $3}')
temp=$(echo "$gpu_data" | awk -F ', ' '{print $4}')
fan=$(echo "$gpu_data" | awk -F ', ' '{print $5}')
clock=$(echo "$gpu_data" | awk -F ', ' '{print $6}')
pstate=$(echo "$gpu_data" | awk -F ', ' '{print $7}')
power=$(echo "$gpu_data" | awk -F ', ' '{print $8}')
name=$(echo "$gpu_data" | awk -F ', ' '{print $9}')
echo "{\"text\":\"/ G ${gpu_usage}%\",\"tooltip\":\"GPU: ${name}\\nUsage: ${gpu_usage}%\\nMemory: ${mem_used}/${mem_total} MiB\\nTemp: ${temp}°C\\nFan: ${fan}%\\nClock: ${clock} MHz\\nP-state: ${pstate}\\nPower: ${power} W\"}"

