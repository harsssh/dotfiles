#!/usr/bin/env bash
# Claude Code の Stop, StopFailure, Notification hook。ユーザーが戻る必要があることを macOS の通知センターに出す。
# hook は対話シェルの PATH を継承しないため、nix profile 由来のコマンド (jq 等) は使わず、JSON は /usr/bin/plutil で読む。
# 非 0 で終了すると stderr が Claude に返って作業が継続されるため、常に 0 で抜ける。
# source したときは関数の定義だけを行う (notify.test.sh から使う)。
set -u

# hook 入力の JSON から key の値を取り出す。key がなければ空文字列を返す
json_field() {
  local json="$1" key="$2"
  printf '%s' "${json}" | /usr/bin/plutil -extract "${key}" raw -o - - 2>/dev/null || true
}

# 返答の本文から、通知に載せる末尾の行を選ぶ。
# 返答は末尾に次の行動か結果を書くので、それを通知で読めるようにする。
# コードブロックの区切り、表、空行は内容を表さないので飛ばし、行頭のリスト記号と強調記号を外す
summarize_reply() {
  printf '%s\n' "$1" | /usr/bin/awk '
    /^[[:space:]]*$/ { next }
    /^[[:space:]]*(```|~~~)/ { next }
    /^[[:space:]]*\|/ { next }
    { line = $0 }
    END {
      sub(/^[[:space:]]*([-*+>]|#+|[0-9]+\.)[[:space:]]+/, "", line)
      gsub(/\*\*|`/, "", line)
      print line
    }'
}

# hook 入力から通知の内容を組み立てる。
# 出力は 3 行で、タイトル、本文、通知音の名前 (なしは空行) の順。通知しない場合は何も出力しない
compose_notification() {
  local json="$1"
  case "$(json_field "${json}" hook_event_name)" in
    Stop)
      local pending
      pending=$(json_field "${json}" background_tasks)
      if [ -n "${pending}" ] && [ "${pending}" != 0 ]; then
        printf '%s\n%s\n\n' "Claude Code: 待機中" "バックグラウンドの作業が ${pending} 件残っています"
      else
        printf '%s\n%s\n\n' "Claude Code: 完了" "$(summarize_reply "$(json_field "${json}" last_assistant_message)")"
      fi
      ;;
    StopFailure)
      printf '%s\n%s\n%s\n' "Claude Code: 停止" "エラーで停止しました: $(json_field "${json}" error)" "Basso"
      ;;
    Notification)
      printf '%s\n%s\n%s\n' "Claude Code: 確認待ち" "$(json_field "${json}" message)" "Glass"
      ;;
  esac
}

# 通知のサブタイトル。どのセッションの通知かを区別するため、プロジェクト名とブランチ名にする
describe_session() {
  local dir="${CLAUDE_PROJECT_DIR:-$PWD}"
  local branch=""
  if [ -x /usr/bin/git ]; then
    branch=$(/usr/bin/git -C "${dir}" branch --show-current 2>/dev/null)
  fi
  # git 管理外や detached HEAD ではブランチ名が空になるので、プロジェクト名だけにする
  if [ -n "${branch}" ]; then
    printf '%s — %s\n' "${dir##*/}" "${branch}"
  else
    printf '%s\n' "${dir##*/}"
  fi
}

main() {
  # 入力は必ず読み切る。閉じたままにすると Claude Code 側が EPIPE になる
  local input
  input=$(cat)

  local notification title body sound
  notification=$(compose_notification "${input}")
  [ -n "${notification}" ] || return 0
  { IFS= read -r title; IFS= read -r body; IFS= read -r sound; } <<<"${notification}"

  # 文字列は argv で渡し、AppleScript のエスケープを不要にする
  [ -x /usr/bin/osascript ] || return 0
  /usr/bin/osascript \
    -e 'on run argv' \
    -e 'set {theTitle, theBody, theSubtitle, theSound} to argv' \
    -e 'if theSound is "" then' \
    -e 'display notification theBody with title theTitle subtitle theSubtitle' \
    -e 'else' \
    -e 'display notification theBody with title theTitle subtitle theSubtitle sound name theSound' \
    -e 'end if' \
    -e 'end run' \
    "${title}" "${body}" "$(describe_session)" "${sound:-}" \
    >/dev/null 2>&1
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
  main
  exit 0
fi
