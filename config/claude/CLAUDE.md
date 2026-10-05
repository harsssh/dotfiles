## 文章

@skills/i-have-adhd/SKILL.md

- 日本語で回答する
- 記号は全角ではなく半角を使う
- 記号、英字の周りに 1 つスペースを入れる
- 順序に意味がない列挙は順序リストではなく箇条書きを使う
- 造語は使わない。日本語として一般的な表現、技術的に正しい表現を使う。英語での呼称を直訳したものも、日本語で一般的に使われるものではないなら禁止

## コーディング

@skills/a-philosophy-of-software-design/a-philosophy-of-software-design.mini.md
@skills/functional-programming-style/SKILL.md
@skills/identifier-naming/SKILL.md

- コードコメントは日本語で書く
- 許可なく formatter, linter のエラーを ignore コメントで無効化してはいけない
- 振る舞いを変える変更には、テストを追加または更新する

## シェル

- alias で `rm` は interactive に実行されるので、ファイルを削除するときは `rm -f` を使う
- PATH 上の sed, find, coreutils (stat, date など) は Nix で入れた GNU 版。macOS だが BSD 版の構文 (`sed -i ''` など) は使わない

## git, gh

- ブランチの切り替えは git-switch、ファイルの復元は git-restore を使う。git-checkout, git-reset は使わない
- 未コミットの変更を破棄する操作 (`git restore .`、`git restore --staged --worktree .`、`git clean` など) はユーザーの指示があるときだけ行う
- ユーザーの指示なく PR を作成してはいけない
- ブランチ名は kebab-case を使う。日付などは含めない
- コミットログには変更の理由 (Why) を書く

## Nix

- コードを変更したら `nix flake check` で検証する
- 再現性が最重要の観点
- 必要な CLI がインストールされていないときは、`nix shell nixpkgs#<pkg> -c <cmd>` や `nix run nixpkgs#<pkg>` で一時的に使ってよい

## Ruby

- 3.1+ の hash shorthand を活用する
