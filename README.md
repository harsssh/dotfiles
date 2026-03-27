# harsssh's dotfiles

nix-darwin + home-manager で macOS / Linux の設定を宣言的に管理する公開用 dotfiles。

このリポジトリは switch 対象ではない。システムへの適用は `dotfiles-private` から行う。

## プロファイル

プロファイルはホスト名をキーとして定義する。`make switch` 実行時にホスト名から自動解決される。

- macOS: `darwin-rebuild switch --flake .` がホスト名で解決
- Linux: `home-manager switch --flake .` が `user@hostname` で解決

Linux 初回 (home-manager 未インストール時) は以下で bootstrap:

```bash
nix run 'home-manager/master' -- switch --flake .
```

実際のプロファイル定義 (ホスト名・ユーザー名・features) は `dotfiles-private` で管理している。`profiles.nix` には CI 用のダミープロファイルのみ含まれる。

## dotfiles-private との関係

機密性のある設定は別リポジトリ `dotfiles-private` で管理している。

- `dotfiles`: 共通設定とライブラリ関数 (`mkConfigurations`) を提供
- `dotfiles-private`: dotfiles を flake input として参照し、プロファイルとプライベートモジュールを注入

`dotfiles` 単体でビルドする場合は CI 用プロファイルのみで動作する。

## features

プロファイルごとに有効/無効を切り替えたい設定は feature として定義し、`profiles.nix` の `features` で指定する。

feature は 2 種類ある:

- public feature: `modules/features.nix` で定義。このリポジトリに含まれる
- private feature: `dotfiles-private` から注入。機密性のある設定用

両者は同じ仕組みで解決され、`flake.nix` で統合される。

## `config/` ディレクトリ

Nix で設定を書くメリットがないものは、`config/` に設定ファイルを配置して配布するだけにしている。
