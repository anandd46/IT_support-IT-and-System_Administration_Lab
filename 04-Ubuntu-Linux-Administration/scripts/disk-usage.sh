#!/bin/bash
# ============================================================
# IT Support Lab - Linux Disk Space & Usage Analysis
# Author: Anand D
# Description: Checks filesystem usage and highlights full partitions. Read-only.
# ============================================================

echo "============================================"
echo "   IT SUPPORT LAB - DISK USAGE REPORT       "
echo "============================================"
echo ""

echo "--- FILESYSTEM CAPACITIES ---"
df -h --output=source,size,used,avail,pcent,target | column -t
echo ""

echo "--- PARTITION CAPACITY ALERTS ---"
ALERT_TRIGGERED=0
df -h --output=pcent,target | tail -n +2 | while read -r pct target; do
    clean_pct="${pct%\%}"
    if [ "$clean_pct" -ge 90 ]; then
        echo "CRITICAL: Partition $target is at ${pct} capacity!"
        ALERT_TRIGGERED=1
    elif [ "$clean_pct" -ge 80 ]; then
        echo "WARNING: Partition $target is at ${pct} capacity."
        ALERT_TRIGGERED=1
    fi
done
if [ "$ALERT_TRIGGERED" -eq 0 ]; then
    echo "All filesystems operating within healthy thresholds (<80%)."
fi
echo ""

echo "--- TOP 5 LARGEST LOG FILES IN /var/log ---"
find /var/log -type f -exec ls -lh {} + 2>/dev/null | sort -rh -k 5 | head -5 | awk '{print $5, $9}'
echo ""

echo "============================================"
echo "   DISK USAGE REPORT COMPLETE               "
echo "============================================"
