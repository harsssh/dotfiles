---
name: apply
description: >-
  dotfiles の変更を commit し、main に push して、dotfiles-private の make sync でこの PC に反映する。
  「apply」「commit push 反映」「dsync まで」と言われたときに使う。
disable-model-invocation: true
---

# apply

dotfiles の変更を commit, push し、`~/dotfiles-private` の `make sync` でこの PC のシステム構成に反映する。

## サンドボックス

次の 2 つのコマンドは、最初から `dangerouslyDisableSandbox: true` で実行する。サンドボックス内で試して失敗を確認する必要はない。

- `git push` と、リモートを読む `git pull --rebase`, `git fetch`: SSH 接続がサンドボックス内では切れる。
- `make sync`: 中で `sudo darwin-rebuild switch` を実行する。サンドボックス内では sudo が動かない。

sudo の承認は Touch ID で利用者が行う。パスワードを尋ねたり、`sudo -S` で渡したりしない。

## 手順

1. 作業ツリーの状態を確認する。

   ```bash
   git status -sb
   ```

2. 未コミットの変更があるときは `nix flake check` を実行する。失敗したら、結果を報告して止まる。commit しない。

3. 未コミットの変更があるときは commit する。
   - コミットメッセージは `<対象>: <変更内容>` の 1 行目と、変更の理由 (Why) を書いた本文にする。直近の `git log` の書き方に合わせる。
   - ブランチは切らず、main に直接 commit する。
   - コミットログの末尾には、システムが指定する Co-Authored-By 行を付ける。

4. 未 push のコミットがあるときは push する。リモートに手元にないコミットがあり拒否されたら、`git fetch` で内容を確認し、競合しなければ `git pull --rebase` のあとに push する。競合したら止まって報告する。

5. `make sync` を実行する。`dsync` は alias なので、非対話シェルでは展開されない。展開後のコマンドを直接使う。

   ```bash
   cd ~/dotfiles-private && make sync
   ```

   ビルドに時間がかかるため、`timeout` は 600000 を指定する。

## 報告

- commit のハッシュ、push 先、`make sync` の成否を伝える。
- 手順をスキップしたときは、その理由を伝える (例: 未コミットの変更がなかった)。
- 失敗した手順があれば、出力を添えて報告し、後続の手順は実行しない。
