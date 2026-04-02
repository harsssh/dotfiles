# harsssh's dotfiles

nix-darwin + home-manager で macOS / Linux の設定を宣言的に管理する公開用 dotfiles。

このリポジトリは switch 対象ではない。システムへの適用は `dotfiles-private` から行う。

## プロファイル

プロファイルは `{ system, username, darwin?, home? }` の形式で定義する。`make switch` 実行時にホスト名から自動解決される。

- macOS: `darwin-rebuild switch --flake .` がホスト名で解決
- Linux: `home-manager switch --flake .` が `user@hostname` で解決

Linux 初回 (home-manager 未インストール時) は以下で bootstrap:

```bash
nix run 'home-manager/master' -- switch --flake .
```

実際のプロファイル定義は `dotfiles-private` で管理している。`profiles.nix` には CI 用プロファイルのみ含まれる。

## dotfiles-private との関係

機密性のある設定は別リポジトリ `dotfiles-private` で管理している。

- `dotfiles`: 共通設定と `mkConfigurations` を提供
- `dotfiles-private`: dotfiles を flake input として参照し、プロファイルとプライベートモジュールを注入

`dotfiles` 単体でビルドする場合は CI 用プロファイルのみで動作する。

## features

プロファイルごとに有効/無効を切り替えたい設定は feature として定義する。各 feature は `lib/mkFeature.nix` ヘルパーを使い、`mkEnableOption` + `mkIf` パターンで実装される。

プロファイルの `home` または `darwin` モジュール内で `features.<name>.enable = true` を設定すると有効になる。

feature は 2 種類ある:

- public feature: `modules/{darwin,home}/features/` にモジュールを作成し、対応する `default.nix` で import する
- private feature: `dotfiles-private` から `homeModules`/`darwinModules` として注入する

## `config/` ディレクトリ

Nix で設定を書くメリットがないものは、`config/` に設定ファイルを配置して配布するだけにしている。
