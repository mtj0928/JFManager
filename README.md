# JFManager
ジュース会・食品会管理アプリ

## How To Build
iOS アプリ開発で頻繁に利用されている Carthage というパッケージ管理ツールを用いています。

インストールには HomeBrew を使います。

```
$ brew install carthage
$ carthage update --platform iOS 
```

その後、[ここ](https://qiita.com/nakamurau1@github/items/0b93f07f40a86e97804b#4-carthageコマンドを実行)を参考に Xcode にライブラリを追加してください。

以上を行なった上で Xcode で `JFManager.xcodeproj` を開いてビルドするとシミュレータが起動します。
