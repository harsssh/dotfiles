#!/usr/bin/env bash
# Claude Code の Stop hook。ターンの完了を macOS の通知センターに出す。
# hook は対話シェルの PATH を継承しないため、nix profile 由来のコマンド (jq 等) は使わない。
# プロジェクトのパスは stdin の JSON ではなく Claude Code が渡す環境変数から取る。
# 非 0 で終了すると stderr が Claude に返って作業が継続されるため、常に 0 で抜ける。
set -u

# hook 入力を読み捨てる。閉じたままにすると Claude Code 側が EPIPE になる
cat >/dev/null

dir="${CLAUDE_PROJECT_DIR:-$PWD}"
subtitle="${dir##*/}"

branch=""
if [ -x /usr/bin/git ]; then
  branch=$(/usr/bin/git -C "${dir}" branch --show-current 2>/dev/null)
fi
# git 管理外や detached HEAD ではブランチ名が空になるので、プロジェクト名だけにする
if [ -n "${branch}" ]; then
  subtitle="${subtitle} — ${branch}"
fi

# AppleScript 文字列リテラルに埋め込むためのエスケープ
subtitle="${subtitle//\\/\\\\}"
subtitle="${subtitle//\"/\\\"}"

if [ -x /usr/bin/osascript ]; then
  /usr/bin/osascript \
    -e "display notification \"作業が完了しました\" with title \"Claude Code\" subtitle \"${subtitle}\"" \
    >/dev/null 2>&1
fi

exit 0
