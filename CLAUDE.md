# harsssh's dotfiles

このリポジトリは公開用の dotfiles。nix-darwin + home-manager で macOS の設定を宣言的に管理する。

## プロファイル

`profiles.nix` で環境ごとのプロファイル (work, personal など) を定義している。同じ dotfiles を複数のマシンで使い分けるための仕組み。

## dotfiles-private との関係

機密性のある設定は別リポジトリ `dotfiles-private` で管理している。

- `dotfiles`: 共通設定とライブラリ関数を提供
- `dotfiles-private`: dotfiles を flake input として参照し、プライベートモジュールを注入

## dotfiles-private からのモジュール注入

`privateFeatures` によりプライベートモジュールの注入を制御する。

1. `profiles.nix` で各プロファイルが必要とする `privateFeatures` を宣言する
2. `dotfiles-private` でプライベートモジュールを定義し、feature 名と紐付ける
3. ビルド時、プロファイルの `privateFeatures` に対応するモジュールが解決され注入される

モジュールは `type` により home-manager モジュールか nix-darwin モジュールとして注入される。

`dotfiles` 単体でビルドする場合は `privateFeatures` が解決されないため、プライベートモジュールなしで動作する。

## `config/` ディレクトリ

Nix で設定を書くメリットがないものは、`config/` に設定ファイルを配置して配布するだけにしている。
