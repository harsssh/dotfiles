# CLAUDE.md ユーザー設定

## 応答スタイル

- 日本語で回答する

@skills/i-have-adhd/SKILL.md

## 文章

- 記号は全角ではなく半角を使う
- 記号、英字の周りに 1 つスペースを入れる
- 順序に意味がない列挙は順序リストではなく箇条書きを使う
- 造語は使わない。日本語として一般的な表現、技術的に正しい表現を使う。英語での呼称を直訳したものも、日本語で一般的に使われるものではないなら禁止

## コーディング

### 設計・品質

@skills/a-philosophy-of-software-design/a-philosophy-of-software-design.mini.md

- コードコメントは日本語で書く
- 許可なく formatter, linter のエラーを ignore コメントで無効化してはいけない

### 関数型プログラミングスタイル

@skills/functional-programming-style/SKILL.md

### 命名

- 識別子 (関数・変数・型) は、説明しきれないほど特化した命名に注意する
- 述語は肯定形で命名
- 仕様書の語彙をコードに反映する。独自の語を作らず、仕様・コード・テスト・API で同じ概念を同じ語で呼ぶ
- 英文法的に自然な識別子を選ぶ

### テスト

- 振る舞いを変える変更には、テストを追加または更新する。テストを書く前に write-tests skill を使う
- 変更後はテストを実行し、結果をそのまま報告する。テストを通すために期待値の書き換えや skip をしない

## 言語・ツール別

### シェル

- alias で `rm` は interactive に実行されるので、ファイルを削除するときは `rm -f` を使う
- PATH 上の sed, find, coreutils (stat, date など) は Nix で入れた GNU 版。macOS だが BSD 版の構文 (`sed -i ''` など) は使わない

### git, gh

- ブランチの切り替えは git-switch、ファイルの復元は git-restore を使う。git-checkout, git-reset は使わない
- 未コミットの変更を破棄する操作 (`git restore .`、`git reset --hard`、`git clean` など) はユーザーの指示があるときだけ行う
- ユーザーの指示なく PR を作成してはいけない
- ブランチ名は kebab-case を使う。日付などは含めない
- コミットログには変更の理由 (Why) を書く

### Nix

- 作業が完了したら `nix flake check` で検証する
- 再現性を最重視して設定を書く
- warning は解消する。解消できない warning はその理由を報告する
- 必要な CLI がインストールされていないときは、`nix shell nixpkgs#<pkg> -c <cmd>` や `nix run nixpkgs#<pkg>` で一時的に使ってよい

### Ruby

- 3.1+ の hash shorthand を活用する
- 重複する setup は shared_examples / shared_context に括り出す
