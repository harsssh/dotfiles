# CLAUDE.md ユーザー設定

Always use context7 when I need code generation, setup or
configuration steps, or library/API documentation. This means
you should automatically use the Context7 MCP tools to resolve
library id and get library docs without me having to
explicitly ask.

---

## 全般
- 日本語で回答する

## 文章
- 記号は全角ではなく半角のものを使う
- 記号、英字の周りに 1 つスペースを入れる
- 太字や斜体などの過度な装飾はしない。ただし、見出しや箇条書きなど文構造を表現する記法は使ってよい。
- 順序に意味がない列挙は順序リストではなく箇条書きを使う。
- 冗長な表現は使わない。例: 確認を行う → 確認する / このセクションでは〜 → (不要)

## コーディング
- コードには How, テストコードには What, コミットログには Why, コードコメントには Why not を書く
    - 関数の処理内容を説明するだけのコメントは書いてはいけない。説明が必要なほど長い関数は分割するべきである。
- git-switch, git-restore を使って安全に git リポジトリを操作して。git-checkout, git-reset を乱用しない。
- formatter, linter のエラーを ignore コメントで無効化してはいけない

## その他
- alias で `rm` は interactive に実行されるので、Claude がファイルを削除するときは `rm -f` を使う

## Nix
- 作業が完了したら `nix flake check` で検証する
- 再現性を最重視して設定を書く
- すべてを無理に Nix で管理しなくて良い。手軽に Nix の恩恵を受けれる部分だけ Nix 化すること。
- warning は無視せず可能な限り解消すること
- 動作確認が済んだら、関数型らしいスタイルにリファクタリングする
