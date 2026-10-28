設計や使い方は README.md を参照。

このプロジェクトで設定の変更などを依頼した場合は、git 管理下のファイルを編集すること。
配置された設定ファイルを直接編集しない。
リポジトリ内にあっても `.gitignore` で除外されたファイルは編集先ではない。編集先がわからないときは、`modules/` から配置先のパスを検索して、どのモジュールが配置しているかを確かめる。

## コミット

ブランチを切らず、main に直接コミットする。

## モジュールの追加手順

全ホスト共通の設定は、`modules/darwin/` または `modules/home/` にモジュールを作成し、対応する `default.nix` の `imports` に追加する。

ホストごとに有効/無効を切り替える設定は、`dotfiles.<name>.enable` を `mkEnableOption` で定義し、`mkIf` でガードする (例: `modules/home/1password.nix`)。ホスト固有の値は `dotfiles-private` のホストモジュールに直接書き、切り替え用モジュールは作らない。

## dotfiles-private との関係

`flake.nix` は `homeModules.default` と `darwinModules.default` を公開する。`dotfiles-private` はこれらを `nix-darwin.lib.darwinSystem` / `home-manager.lib.homeManagerConfiguration` の `modules` に含め、ホストモジュールと組み合わせて構成を定義する。

`darwinConfigurations.ci-darwin` と `homeConfigurations."runner@ci-linux"` は CI 用の最小構成で、実機の構成は含まない。

## Claude Code の設定管理

`modules/home/claude.nix` で管理している。

- `settings.json` の値 (プラグインの有効化、permissions、hooks など) は `managedSettings` に書く。`~/.claude/settings.json` は CLI が書き込む実ファイルで、activation で `managedSettings` がマージされる
- `CLAUDE.md`、スキル、hook のスクリプトは `config/claude/` 以下を編集する
- プラグイン名は推測で書かず、`~/.claude/plugins/marketplaces/<marketplace>/.claude-plugin/marketplace.json` に存在することを確かめる
- claude.ai のコネクタや、claude.ai のアカウントで配布されるスキル (`anthropic-skills:*`) は claude.ai 側の設定で、Nix では管理しない

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
