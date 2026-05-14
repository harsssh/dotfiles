設計や使い方は README.md を参照。

このプロジェクトで設定の変更などを依頼した場合は、git 管理下のファイルを編集すること。
配置された設定ファイルを直接編集しない。

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

## neovim の設定管理

設定は `modules/home/neovim/` 以下にある。nixvim で管理している。

### plugins/ の構成と配置方針

- `editing.nix`: treesitter など構文解析・インデント・テキスト編集系。言語固有のシンタックスプラグインもここ。
- `lsp.nix`: none-ls (フォーマッタ) と LSP attach 処理。
- `ui.nix`: ステータスライン・サイン・装飾など見た目系。
- `util.nix`: セッション管理・ターミナル・tmux 連携など。
- `completion.nix`: 補完系。
- `snacks.nix`: snacks.nvim の設定。

### nixvim の managed plugin にないものを追加する場合

`extraPlugins` に `pkgs.vimPlugins.<name>` を追加し、`extraConfigLua` で `require("...").setup({})` を呼ぶ。配置先は上記の構成に従う。
