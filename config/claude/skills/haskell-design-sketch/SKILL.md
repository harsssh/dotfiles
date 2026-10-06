---
name: haskell-design-sketch
description: >-
  設計の概要を Haskell のコード例で示す。型定義と関数シグネチャだけで構造を表現し、
  実装言語での対応手段を併記する。設計を議論しているとき、データ構造・責務の分割・
  状態遷移・エラーの扱い・純粋関数と副作用の境界を検討しているときに使う。
  実装コードを書く段階では使わない。
disable-model-invocation: true
---

# haskell-design-sketch

設計は型で書くと最も短く伝わる。Haskell のコード例は、実装言語の構文や既存コードの都合に引きずられずに構造だけを議論するために書く。

## 前提

- コード例は動くプログラムではなく設計の図。関数の本体は書かない
- 提示する言語と実装する言語は別。Haskell の構造をそのまま実装言語に持ち込むことは勧めない。特に Maybe や Either を模倣するクラス・ライブラリの導入は提案しない
- 使うのは data / newtype / type / class / 関数シグネチャ / Maybe / Either / IO と、「使ってよい拡張」に挙げたものの範囲に限る。型レベルの技巧は使わない。この範囲で表現できない設計は、コードではなく文章で説明する
- モナド変換子は、工程を順に繋いだ 1 本道を示す `ExceptT e IO` だけ使ってよい。実装言語では早期 return になるものなので、そのまま持ち込むことは勧めない

## 手順

1. 議論している設計から、登場する値・状態・操作を列挙する
2. 型定義とシグネチャを書く。純粋な操作と副作用を持つ操作を分けて並べる
3. 型から読み取れない制約 (不変条件、事前条件、副作用の順序) を文章で補う
4. 実装言語での対応手段を書く。その言語で標準的な手段に限る
5. 設計上の選択肢が複数あるなら、型の違いとして並べ、何が保証されるかの差で比較する

## 型の書き方

型の設計は functional-programming-style の規則に従う。Haskell では次のように書く。

- 列挙型は直和型で書く
- 失敗しうる操作は `Either Error a`、値の不在は `Maybe a` で戻り値の型に表す
- 意味の違う文字列や数値は newtype で区別する
- フィールド名に型名の接頭辞を付けない (`accountId` ではなく `id`)。フィールドは型ごとの名前空間にあるものとして書き、参照はドットで書く
- 型定義と主要なシグネチャで 40 行以内を目安にする。網羅ではなく骨格を示す。省略は `-- ...` で示す

## 使ってよい拡張

読みやすさのためだけに使う。実装言語に対応物があるものに限る。

- `OverloadedRecordDot` / `DuplicateRecordFields` / `NoFieldSelectors`
  - フィールドの参照は `t.country.dataRepo` と書く。接頭辞で型を区別しない
  - たいていの実装言語のフィールドアクセスがこの形なので、設計と実装で名前が変わらない
- `NamedFieldPuns`
  - パターンではフィールド名をそのまま束縛する (`Variant { country, command }`)。位置で覚えさせない
- `ExistentialQuantification`
  - 型引数を登録時に隠す構造を書くときだけ使う。`forall` は明示する

使わないもの。

- `RecordWildCards`: 束縛の出所がコード例から読めない
- `OverloadedStrings`: 意味の違う文字列を newtype で区別する方針と逆になる
- `GADTs`: 存在型の `forall` が消えて、何が隠れているかが読めない
- `OverloadedRecordUpdate`: 実験的。ネストした更新が要る設計は、記法ではなく構造を疑う
- `TypeApplications`, `TypeFamilies`, `DerivingVia` などの型レベルの拡張: 実装言語に対応物が無い

## 例

```haskell
newtype RawInput = RawInput Text
newtype UserId = UserId Text

-- 参照は account.plan のようにドットで書く
data Account = Account
  { id   :: UserId
  , plan :: Plan
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
- フィールドのドットアクセス: Go や TypeScript はそのまま同じ形。Ruby なら attr_reader。どの言語でも型名の接頭辞は付けない

## 注意

- コード例で終わらせない。何が型で保証され、何が保証されないかを明示する
- Haskell に寄せると実装が不自然になる箇所は、その旨を指摘して実装言語での代替を示す
- 目的は設計の議論。Haskell の言語機能の解説はしない
