#!/usr/bin/env bash
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

bar_width=10
filled=$((pct * bar_width / 100))
empty=$((bar_width - filled))
bar=""
[ "$filled" -gt 0 ] && bar=$(printf "%${filled}s" | tr ' ' '▓')
[ "$empty" -gt 0 ] && bar="${bar}$(printf "%${empty}s" | tr ' ' '░')"

echo "[$model] $bar $pct%"
