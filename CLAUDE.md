設計や使い方は README.md を参照。

## privateFeatures によるモジュール注入

`privateFeatures` によりプライベートモジュールの注入を制御する。

プライベートモジュールの追加手順:

1. `dotfiles-private` でモジュールを定義し、名前をつけて `dotfiles` から export しているコンストラクタに渡す
2. `dotfiles` の `profiles.nix` でその名前を `privateFeatures` として参照する

モジュールは `type` により home-manager モジュールか nix-darwin モジュールとして注入される。
