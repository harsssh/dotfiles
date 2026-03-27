設計や使い方は README.md を参照。

## public feature の追加手順

1. `modules/darwin/features/` または `modules/home/features/` にモジュールを作成
   - `mkEnableOption` で `features.<name>.enable` を定義
   - `enabledFeatures` リストから `mkDefault` で自動有効化
   - `mkIf` で設定をガード
2. 対応する `default.nix` (`modules/home/default.nix` または `modules/darwin/default.nix`) の `imports` に追加

## private feature・プロファイルの注入

`dotfiles-private` は `flake.nix` が export する `mkConfigurations` に以下を渡す:

- `homeModules`: private home-manager モジュールファイルのリスト
- `darwinModules`: private nix-darwin モジュールファイルのリスト
- `profiles`: ホスト名をキーとしたプロファイル定義

`mkConfigurations` は `{ darwinConfigurations, homeConfigurations }` を返す。

`profiles.nix` には CI 用の最小プロファイルのみ含まれる。実際のホスト名・ユーザー名・features は `dotfiles-private` から注入する。
