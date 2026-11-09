#!/usr/bin/env bash
# notify.sh の通知の組み立てを確かめる。/usr/bin/plutil を使うので macOS で実行する。
# 実行: bash config/claude/hooks/notify.test.sh
set -u

# shellcheck source-path=SCRIPTDIR
. "$(dirname "$0")/notify.sh"

failures=0

assert_notification() {
  local name="$1" input="$2" expected="$3"
  local actual
  actual=$(compose_notification "${input}")
  if [ "${actual}" = "${expected}" ]; then
    printf 'ok: %s\n' "${name}"
  else
    printf 'FAIL: %s\n  expected: %q\n  actual:   %q\n' "${name}" "${expected}" "${actual}"
    failures=$((failures + 1))
  fi
}

assert_notification "完了は返答の末尾の行を本文にする" \
  '{"hook_event_name":"Stop","last_assistant_message":"結果です。\n\n次の一手: テストを実行する","background_tasks":[]}' \
  $'Claude Code: 完了\n次の一手: テストを実行する'

assert_notification "末尾のコードブロックの区切り、表、空行を飛ばし、Markdown の記号を外す" \
  "{\"hook_event_name\":\"Stop\",\"last_assistant_message\":\"- **次の一手**: \`make sync\` を実行する\\n| a | b |\\n|---|---|\\n\`\`\`\\n\\n\"}" \
  $'Claude Code: 完了\n次の一手: make sync を実行する'

assert_notification "バックグラウンドの作業が残っていれば待機中にする" \
  '{"hook_event_name":"Stop","last_assistant_message":"待ちます","background_tasks":[{"id":"a"},{"id":"b"}]}' \
  $'Claude Code: 待機中\nバックグラウンドの作業が 2 件残っています'

assert_notification "エラーで停止したら種類を通知音つきで出す" \
  '{"hook_event_name":"StopFailure","error":"rate_limit"}' \
  $'Claude Code: 停止\nエラーで停止しました: rate_limit\nBasso'

assert_notification "確認待ちはメッセージを通知音つきで出す" \
  '{"hook_event_name":"Notification","message":"Claude needs your permission to use Bash","notification_type":"permission_prompt"}' \
  $'Claude Code: 確認待ち\nClaude needs your permission to use Bash\nGlass'

assert_notification "対象外のイベントは通知しない" \
  '{"hook_event_name":"SessionStart"}' \
  ''

[ "${failures}" -eq 0 ]
