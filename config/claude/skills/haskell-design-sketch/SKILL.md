---
name: haskell-design-sketch
description: >-
  設計の概要を Haskell のコード例で示す。型定義と関数シグネチャだけで構造を表現し、
  実装言語での対応手段を併記する。設計を議論しているとき、データ構造・責務の分割・
  状態遷移・エラーの扱い・純粋関数と副作用の境界を検討しているときに使う。
  「Haskell で」「型で表すと」「設計を整理したい」「設計方針を相談したい」
  と言われたときは必ず使う。実装コードを書く段階では使わない。
---

# haskell-design-sketch

設計は型で書くと最も短く伝わる。Haskell のコード例は、実装言語の構文や既存コードの都合に引きずられずに構造だけを議論するために書く。

## 前提

- コード例は動くプログラムではなく設計の図。関数の本体は書かない
- 提示する言語と実装する言語は別。Haskell の構造をそのまま実装言語に持ち込むことは勧めない。特に Maybe や Either を模倣するクラス・ライブラリの導入は提案しない
- 使うのは data / newtype / type / 関数シグネチャ / Maybe / Either / IO の範囲に限る。GHC 拡張、型レベルの技巧、モナド変換子は使わない。この範囲で表現できない設計は、コードではなく文章で説明する

## 手順

1. 議論している設計から、登場する値・状態・操作を列挙する
2. 型定義とシグネチャを書く。純粋な操作と副作用を持つ操作を分けて並べる
3. 型から読み取れない制約 (不変条件、事前条件、副作用の順序) を文章で補う
4. 実装言語での対応手段を書く。その言語で標準的な手段に限る
5. 設計上の選択肢が複数あるなら、型の違いとして並べ、何が保証されるかの差で比較する

## 型の書き方

- 取りうる値が有限なら直和型にする
- 状態が異なれば別の型にする (未検証の入力と検証済みの値など)
- 失敗しうる操作は `Either Error a`、値の不在は `Maybe a` で戻り値の型に表す
- 副作用は境界の関数だけが持つ。判断・変換は純粋関数のシグネチャとして書く
- 意味の違う文字列や数値は newtype で区別する
- 型定義と主要なシグネチャで 40 行以内を目安にする。網羅ではなく骨格を示す。省略は `-- ...` で示す

## 例

```haskell
newtype RawInput = RawInput Text
newtype UserId = UserId Text

data Account = Account
  { accountId :: UserId
  , accountPlan :: Plan
  }

data Plan = Free | Pro | Enterprise

data ValidationError = EmptyInput | TooLong Int

-- 純粋: 検証と判断
validate :: RawInput -> Either ValidationError UserId
canInvite :: Plan -> Bool

-- 副作用: 取得と保存のみ
findAccount :: UserId -> IO (Maybe Account)
saveAccount :: Account -> IO ()
```

実装言語への対応の書き方の例:

- `Plan` のような直和型: Ruby なら定数と網羅的な case-in、TypeScript なら union type
- `Either ValidationError UserId`: 例外か、成功と失敗を別の型で返すか。どちらもその言語の標準的な流儀に従う
- `RawInput` と `UserId` の区別: 別クラス・別型にするか、区別を諦めて命名と検証位置で担保するか

## 注意

- コード例で終わらせない。何が型で保証され、何が保証されないかを必ず明示する
- Haskell に寄せると実装が不自然になる箇所は、その旨を指摘して実装言語での代替を示す
- 目的は設計の議論。Haskell の言語機能の解説はしない
