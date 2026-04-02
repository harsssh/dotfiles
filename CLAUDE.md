設計や使い方は README.md を参照。

## public feature の追加手順

1. `modules/darwin/features/` または `modules/home/features/` にモジュールを作成
   - `lib/mkFeature.nix` ヘルパーを使う
   - `mkEnableOption` で `features.<name>.enable` を定義
   - `mkIf` で設定をガード
2. 対応する `default.nix` (`modules/home/default.nix` または `modules/darwin/default.nix`) の `imports` に追加
3. プロファイルの `home` または `darwin` モジュール内で `features.<name>.enable = true` を設定

## private feature・プロファイルの注入

`dotfiles-private` は `flake.nix` が export する `mkConfigurations` に以下を渡す:

- `homeModules`: private home-manager モジュールファイルのリスト
- `darwinModules`: private nix-darwin モジュールファイルのリスト
- `profiles`: ホスト名をキーとしたプロファイル定義 (`{ system, username, darwin?, home? }`)

`mkConfigurations` は `{ darwinConfigurations, homeConfigurations }` を返す。

`profiles.nix` には CI 用の最小プロファイルのみ含まれる。実際のホスト定義は `dotfiles-private` から注入する。
