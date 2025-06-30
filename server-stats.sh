#!/bin/bash

echo "==================== 📊 Server Performance Stats ===================="
echo "Generated on: $(date)"
echo "====================================================================="

# 🔸 OS Version
echo -e "\n📦 OS Version:"
sw_vers

# 🔸 Uptime
echo -e "\n⏱️ Uptime:"
uptime

# 🔸 Load Average
echo -e "\n📈 Load Average (1, 5, 15 min):"
sysctl -n vm.loadavg

# 🔸 Logged-in Users
echo -e "\n👤 Logged-in Users:"
who

# 🔸 CPU Usage (macOS version of top)
echo -e "\n🖥️ Total CPU Usage:"
top -l 1 | grep "CPU usage"

# 🔸 Memory Usage (macOS version of vm_stat)
echo -e "\n🧠 Memory Usage:"
pages_free=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
pages_active=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
pages_inactive=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
pages_speculative=$(vm_stat | grep "Pages speculative" | awk '{print $3}' | sed 's/\.//')
page_size=$(vm_stat | grep "page size of" | awk '{print $8}')

free_mem=$(( ($pages_free + $pages_speculative) * $page_size / 1024 / 1024 ))
used_mem=$(( ($pages_active + $pages_inactive) * $page_size / 1024 / 1024 ))

echo "Used: ${used_mem}MB"
echo "Free: ${free_mem}MB"

# 🔸 Disk Usage
echo -e "\n💽 Disk Usage:"
df -h /

# 🔸 Top 5 Processes by CPU
echo -e "\n🔥 Top 5 Processes by CPU Usage:"
ps -A -o pid,%cpu,comm | sort -nrk 2 | head -n 6

# 🔸 Top 5 Processes by Memory
echo -e "\n💾 Top 5 Processes by Memory Usage:"
ps -A -o pid,%mem,comm | sort -nrk 2 | head -n 6

echo "====================================================================="
