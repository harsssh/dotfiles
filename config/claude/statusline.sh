#!/usr/bin/env bash
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name')
effort=$(echo "$input" | jq -r '.effort.level // empty')
fast=$(echo "$input" | jq -r 'if .fast_mode then "fast" else empty end')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
# resets_at を date で整形しないのは、macOS と Linux で epoch を渡すオプションが異なるため
five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour // empty | "\(.used_percentage | floor) \(.resets_at | strflocaltime("%H:%M"))"')
seven_day=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty | floor')

colorize() {
  local pct=$1 text=$2 color=""
  if [ "$pct" -ge 90 ]; then
    color='\033[31m'
  elif [ "$pct" -ge 70 ]; then
    color='\033[33m'
  fi
  if [ -n "$color" ]; then
    printf "${color}%s\033[0m" "$text"
  else
    printf "%s" "$text"
  fi
}

# detached HEAD ではブランチ名が空になるため、短縮ハッシュで代替する
current_branch() {
  local dir=$1 branch
  [ -n "$dir" ] || return 0
  branch=$(git -C "$dir" branch --show-current 2>/dev/null) || return 0
  [ -n "$branch" ] || branch=$(git -C "$dir" rev-parse --short HEAD 2>/dev/null)
  printf "%s" "$branch"
}

branch=$(current_branch "$cwd")

bar_width=5
filled=$((pct * bar_width / 100))
empty=$((bar_width - filled))
bar=""
[ "$filled" -gt 0 ] && bar=$(printf "%${filled}s" | tr ' ' '#')
[ "$empty" -gt 0 ] && bar="${bar}$(printf "%${empty}s" | tr ' ' '-')"

label="$model"
[ -n "$effort" ] && label="$label $effort"
[ -n "$fast" ] && label="$label $fast"

line="[$label] $(colorize "$pct" "$bar $pct%")"

limits=""
if [ -n "$five_hour" ]; then
  read -r five_hour_pct five_hour_reset <<<"$five_hour"
  limits="5h:$(colorize "$five_hour_pct" "$five_hour_pct%")"
  [ "$five_hour_pct" -ge 70 ] && limits="$limits(~$five_hour_reset)"
fi
[ -n "$seven_day" ] && limits="${limits:+$limits }7d:$(colorize "$seven_day" "$seven_day%")"
[ -n "$limits" ] && line="$line | $limits"
[ -n "$branch" ] && line="$line | $branch"

printf "%s\n" "$line"
