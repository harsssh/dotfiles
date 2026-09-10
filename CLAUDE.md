設計や使い方は README.md を参照。

このプロジェクトで設定の変更などを依頼した場合は、git 管理下のファイルを編集すること。
配置された設定ファイルを直接編集しない。

## モジュールの追加手順

全ホスト共通の設定は、`modules/darwin/` または `modules/home/` にモジュールを作成し、対応する `default.nix` の `imports` に追加する。

ホストごとに有効/無効を切り替える設定は、`dotfiles.<name>.enable` を `mkEnableOption` で定義し、`mkIf` でガードする (例: `modules/home/1password.nix`)。ホスト固有の値は `dotfiles-private` のホストモジュールに直接書き、切り替え用モジュールは作らない。

## dotfiles-private との関係

`flake.nix` は `homeModules.default` と `darwinModules.default` を公開する。`dotfiles-private` はこれらを `nix-darwin.lib.darwinSystem` / `home-manager.lib.homeManagerConfiguration` の `modules` に含め、ホストモジュールと組み合わせて構成を定義する。

`darwinConfigurations.ci-darwin` と `homeConfigurations."runner@ci-linux"` は CI 用の最小構成で、実機の構成は含まない。

## neovim の設定管理

設定は `modules/home/neovim/` 以下にある。nixvim で管理している。nixvim のモジュール自体は `flake.nix` の `homeModules.default` で import している。

### plugins/ の構成と配置方針

- `editing.nix`: treesitter など構文解析・インデント・テキスト編集系。言語固有のシンタックスプラグインもここ。
- `lsp.nix`: none-ls (フォーマッタ) と LSP attach 処理。
- `ui.nix`: ステータスライン・サイン・装飾など見た目系。
- `util.nix`: セッション管理・ターミナル・tmux 連携など。
- `completion.nix`: 補完系。
- `snacks.nix`: snacks.nvim の設定。

### nixvim の managed plugin にないものを追加する場合

`extraPlugins` に `pkgs.vimPlugins.<name>` を追加し、`extraConfigLua` で `require("...").setup({})` を呼ぶ。配置先は上記の構成に従う。
