# growth-tree-server
部下の成長管理アプリケーションgrowth treeのサーバー側についてのリポジトリです。

## 開発環境

- Ruby 3.1.1

- Ruby on Rails 6.1.5

## 開発資料

開発初期のデータベース設計にはAirTableを利用しました。(開発途中で色々気づきがあったため、設計内容から大きく変更となりました…)

[AirTableのリンクはこちら](https://airtable.com/shrnqUoZY99xviM1h)

API設計のためStoplight STUDIOを利用しました。

[OpenAPIによるAPI設計の記述はこちら(stoplight.ioにジャンプ)](https://yoshi1011.stoplight.io/docs/growth-tree/YXBpOjU2MDMyNTkz-growth-tree-api)


アプリケーション部分(フロントエンド)はFlutterでWebで実装しており、別リポジトリで管理しています

[アプリケーション実装リポジトリはこちら](https://github.com/yoshi1011/growth_tree_app)

その他、開発管理にJiraを利用しましたが、無料版での公開設定において細かく権限設定が難しかったため、リンク未記載となっております。
