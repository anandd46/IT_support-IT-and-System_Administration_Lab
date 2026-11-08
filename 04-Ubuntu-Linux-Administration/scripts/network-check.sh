#!/bin/bash
# ============================================================
# IT Support Lab - Linux Network Diagnostic Script
# Author: Anand D
# Description: Validates network interfaces, gateway, internet, & DNS. Read-only.
# ============================================================

echo "============================================"
echo "   IT SUPPORT LAB - NETWORK CHECK           "
echo "============================================"
echo ""

echo "--- 1. ACTIVE INTERFACES ---"
ip -brief addr show
echo ""

echo "--- 2. DEFAULT GATEWAY ---"
GW=$(ip route | grep default | awk '{print $3}' | head -1)
if [ -n "$GW" ]; then
    echo "Gateway Detected: $GW"
    if ping -c 3 -W 2 "$GW" >/dev/null 2>&1; then
        echo "RESULT: Gateway is REACHABLE (Ping OK)"
    else
        echo "RESULT: Gateway is UNREACHABLE (Check cable / switch port)"
    fi
else
    echo "RESULT: No Default Gateway configured!"
fi
echo ""

echo "--- 3. PUBLIC INTERNET CONNECTIVITY ---"
if ping -c 3 -W 2 8.8.8.8 >/dev/null 2>&1; then
    echo "RESULT: Public internet (8.8.8.8) is REACHABLE"
else
    echo "RESULT: Cannot reach 8.8.8.8. WAN/ISP routing failure."
fi
echo ""

echo "--- 4. DNS NAME RESOLUTION ---"
if nslookup google.com >/dev/null 2>&1; then
    RESOLVED_IP=$(nslookup google.com | grep "Address:" | tail -1 | awk '{print $2}')
    echo "RESULT: DNS Resolution SUCCESS (google.com -> $RESOLVED_IP)"
else
    echo "RESULT: DNS Resolution FAILED. Check /etc/resolv.conf"
fi
echo ""

echo "============================================"
echo "   NETWORK CHECK COMPLETE                   "
echo "============================================"
