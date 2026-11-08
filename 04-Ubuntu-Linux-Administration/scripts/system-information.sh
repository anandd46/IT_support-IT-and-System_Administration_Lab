#!/bin/bash
# ============================================================
# IT Support Lab - Linux System Information Script
# Author: Anand D
# Description: Gathers comprehensive hardware & OS metrics. Read-only.
# ============================================================

echo "============================================"
echo "   IT SUPPORT LAB - LINUX SYSTEM INFO       "
echo "============================================"
echo ""

echo "--- 1. SYSTEM IDENTIFICATION ---"
echo "Hostname     : $(hostname)"
echo "OS / Distro  : $(lsb_release -d 2>/dev/null | cut -f2 || cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
echo "Kernel       : $(uname -r)"
echo "Architecture : $(uname -m)"
echo "Uptime       : $(uptime -p)"
echo ""

echo "--- 2. CPU HARDWARE ---"
echo "Model        : $(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)"
echo "Cores        : $(nproc)"
echo "Load Average : $(cat /proc/loadavg | awk '{print $1, $2, $3}')"
echo ""

echo "--- 3. MEMORY USAGE ---"
free -h
echo ""

echo "--- 4. FILESYSTEM STORAGE ---"
df -h --output=source,size,used,avail,pcent,target | column -t
echo ""

echo "--- 5. NETWORK INTERFACES ---"
ip -brief addr
echo ""

echo "============================================"
echo "   SYSTEM INFORMATION COMPLETE              "
echo "============================================"
