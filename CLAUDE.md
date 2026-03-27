設計や使い方は README.md を参照。

## public feature の追加手順

1. `modules/darwin/features/` または `modules/home/features/` にモジュールを作成
2. `modules/features.nix` にマッピングを追加
3. `profiles.nix` でその名前を `features` として参照

`type` により home-manager モジュールか nix-darwin モジュールとして注入される。

## private feature・プロファイルの注入

`dotfiles-private` は `flake.nix` が export する `mkConfigurations` に `{ modules, profiles }` を渡す。

- `modules`: private feature のマッピング。public feature と統合され同じ仕組みで解決される。
- `profiles`: ホスト名をキーとしたプロファイル定義。`profiles.nix` の CI 用デフォルトとマージされる。

`mkConfigurations` は `{ darwinConfigurations, homeConfigurations }` を返す。

`profiles.nix` には CI 用の最小プロファイルのみ含まれる。実際のホスト名・ユーザー名・features は `dotfiles-private` から注入する。
