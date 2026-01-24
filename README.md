# harsssh's dotfiles

nix-darwin + home-manager で macOS の設定を宣言的に管理する公開用 dotfiles。

このリポジトリは switch 対象ではない。システムへの適用は `dotfiles-private` から行う。

## プロファイル

`profiles.nix` で環境ごとのプロファイル (work, personal など) を定義している。同じ dotfiles を複数のマシンで使い分けるための仕組み。

## dotfiles-private との関係

機密性のある設定は別リポジトリ `dotfiles-private` で管理している。

- `dotfiles`: 共通設定とライブラリ関数を提供
- `dotfiles-private`: dotfiles を flake input として参照し、プライベートモジュールを注入

`dotfiles` 単体でビルドする場合は private feature が解決されないため、public feature のみで動作する。

## features

プロファイルごとに有効/無効を切り替えたい設定は feature として定義し、`profiles.nix` の `features` で指定する。

feature は 2 種類ある:

- public feature: `modules/features.nix` で定義。このリポジトリに含まれる
- private feature: `dotfiles-private` から注入。機密性のある設定用

両者は同じ仕組みで解決され、`flake.nix` で統合される。

## `config/` ディレクトリ

Nix で設定を書くメリットがないものは、`config/` に設定ファイルを配置して配布するだけにしている。
