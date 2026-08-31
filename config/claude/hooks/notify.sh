#!/usr/bin/env bash
# Claude Code の Stop hook。ターンの完了を macOS の通知センターに出す。
# hook は対話シェルの PATH を継承しないため、nix profile 由来のコマンド (jq 等) は使わない。
# プロジェクト名は stdin の JSON ではなく Claude Code が渡す環境変数から取る。
# 非 0 で終了すると stderr が Claude に返って作業が継続されるため、常に 0 で抜ける。
set -u

# hook 入力を読み捨てる。閉じたままにすると Claude Code 側が EPIPE になる
cat >/dev/null

project="${CLAUDE_PROJECT_DIR:-$PWD}"
project="${project##*/}"
# AppleScript 文字列リテラルに埋め込むためのエスケープ
project="${project//\\/\\\\}"
project="${project//\"/\\\"}"

if [ -x /usr/bin/osascript ]; then
  /usr/bin/osascript \
    -e "display notification \"作業が完了しました\" with title \"Claude Code\" subtitle \"${project}\"" \
    >/dev/null 2>&1
fi

exit 0
