設計や使い方は README.md を参照。

## public feature の追加手順

1. `modules/darwin/features/` または `modules/home/features/` にモジュールを作成
2. `modules/features.nix` にマッピングを追加
3. `profiles.nix` でその名前を `features` として参照

`type` により home-manager モジュールか nix-darwin モジュールとして注入される。

## private feature の注入

`dotfiles-private` は `flake.nix` が export する `mkDarwinConfigurations` にモジュールを渡す。渡されたモジュールは `modules/features.nix` の public feature と統合され、同じ仕組みで解決される。
