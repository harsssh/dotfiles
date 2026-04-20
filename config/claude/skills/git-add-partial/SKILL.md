---
name: git-add-partial
description: >-
  作業ツリーの変更のうち一部だけを非対話的にステージする手順。
  `git add -p` は対話式で Claude から使えないので代わりに使う。
  「コミットを分けて」「このファイルの一部だけコミット」と言われたとき、
  または 1 コミットにまとめるには雑多な diff を前にしたときに必ず使う。
---

# git-add-partial

`git add -p` の非対話版。`git diff` で patch を吐き、不要な hunk を削って `git apply --cached` で戻す。

## 手順

1. 対象ファイルの unified diff を吐く。`diff.external` に difftastic が設定されているので `--no-ext-diff` が必須 (忘れると patch として無効):
   ```bash
   git diff --no-ext-diff -- path/to/file > /tmp/partial.patch
   ```
2. patch を編集し、ステージしたい hunk だけ残す。不要な hunk は `@@ ... @@` と本文 (` `/`+`/`-` で始まる行) を削除。ファイルヘッダ (`diff --git` / `index` / `---` / `+++`) は残す。`@@` の行番号は書き換えなくてよい。
3. インデックスに適用:
   ```bash
   git apply --cached /tmp/partial.patch
   ```
4. `git diff --no-ext-diff --cached` と `git diff --no-ext-diff` で、ステージ済み / 未ステージがそれぞれ意図通りか確認してからコミット。

## 補足

- ファイル境界で分けられるなら `git add <file>` で十分。この skill は 1 ファイル内に複数の論理変更が混在するときに使う。
- 未追跡ファイルは先に `git add -N <file>` (intent-to-add) すると diff に出て同じ手順で扱える。
- バイナリ・リネームは hunk 分割できない。ファイル単位で扱う。
