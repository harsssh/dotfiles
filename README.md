# harsssh's dotfiles

nix-darwin + home-manager で macOS の設定を宣言的に管理する公開用 dotfiles。

このリポジトリは switch 対象ではない。システムへの適用は `dotfiles-private` から行う。

## プロファイル

`profiles.nix` で環境ごとのプロファイル (work, personal など) を定義している。同じ dotfiles を複数のマシンで使い分けるための仕組み。

## dotfiles-private との関係

機密性のある設定は別リポジトリ `dotfiles-private` で管理している。

- `dotfiles`: 共通設定とライブラリ関数を提供
- `dotfiles-private`: dotfiles を flake input として参照し、プライベートモジュールを注入

`dotfiles` 単体でビルドする場合は `privateFeatures` が解決されないため、プライベートモジュールなしで動作する。

## `config/` ディレクトリ

Nix で設定を書くメリットがないものは、`config/` に設定ファイルを配置して配布するだけにしている。
