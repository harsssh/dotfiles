# harsssh's dotfiles

nix-darwin + home-manager で macOS / Linux の設定を宣言的に管理する公開用 dotfiles。

このリポジトリは switch 対象ではない。システムへの適用は `dotfiles-private` から行う。

## 構成

このリポジトリは flake として次を公開する:

- `homeModules.default`: 共通の home-manager モジュール (nixvim を含む)
- `darwinModules.default`: 共通の nix-darwin モジュール。home-manager を組み込み、primary user に `homeModules.default` を適用する
- `darwinConfigurations.ci-darwin`, `homeConfigurations."runner@ci-linux"`: CI 用の最小構成

実機の構成は `dotfiles-private` が上記モジュールを import して定義する。

```nix
darwinConfigurations.<hostname> = nix-darwin.lib.darwinSystem {
  modules = [ dotfiles.darwinModules.default ./hosts/<hostname> ];
};
```

ホスト側で必要な設定は次の通り:

- nix-darwin: `nixpkgs.hostPlatform`, `system.primaryUser`。ユーザー固有の設定は `home-manager.users.<name>` に書く
- home-manager 単体 (Linux): `home.username`, `home.homeDirectory`

適用はホスト名で解決される:

- macOS: `darwin-rebuild switch --flake .` がホスト名で解決
- Linux: `home-manager switch --flake .` が `user@hostname` で解決

Linux 初回 (home-manager 未インストール時) は以下で bootstrap:

```bash
nix run 'home-manager/master' -- switch --flake .
```

## dotfiles-private との関係

機密性のある設定は別リポジトリ `dotfiles-private` で管理している。

- `dotfiles`: 共通設定をモジュールとして提供
- `dotfiles-private`: dotfiles を flake input として参照し、ホストごとの構成を定義してビルドする

`dotfiles` 単体でビルドする場合は CI 用構成のみで動作する。

## ホストごとに切り替える設定

ホスト固有の値 (Homebrew の cask、git の署名鍵など) は、ホスト側のモジュールに直接書く。

複数ホストで共有しつつ有効/無効を切り替えたい設定は、`dotfiles.<name>.enable` オプションを持つモジュールにする (例: `modules/home/1password.nix`)。

## `config/` ディレクトリ

Nix で設定を書くメリットがないものは、`config/` に設定ファイルを配置して配布するだけにしている。

## Claude Code

`~/.claude/settings.json` は Claude Code が実行時状態を書き込むため Nix 管理・git 追跡の対象外
(詳細は `modules/home/claude.nix` のコメント)。hook の登録先はこの settings.json しかないので、
スクリプトだけを配布し、登録は手動で 1 度だけ行う。

macOS で作業完了時に通知を出す hook の登録:

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          { "type": "command", "command": "~/.claude/hooks/notify.sh" }
        ]
      }
    ]
  }
}
```

初回は macOS の通知許可が必要。許可されるまで hook は正常終了するが通知は表示されない。
