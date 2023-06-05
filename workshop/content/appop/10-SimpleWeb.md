通常のLinuxサーバー上で起動するような従来型のアプリケーションをTAP経由でデプロイします。
メニューよりOpen Folder を選択します。

![Graphical user interface, application Description automatically
generated](../media/image40.png)

/home/eduk8s/tap-python-recipies/python-simple-rest/
を入力し、フォルダーを起動します。

左ペインで右クリックを行い、"Tanzu Apply Workload" を選択します。

![グラフィカル ユーザー インターフェイス, アプリケーション
自動的に生成された説明](../media/image41.png)

ワークロードがデプロイされるまで、2-3分待ちます。

ターミナルを起動して、エンドポイントのURLの確認および動作の確認をします。

```
kubectl get ksvc
```
![](../media/image42.png)

webブラウザ経由で上記の URL を入力し、サービス内容を確認します。

![グラフィカル ユーザー インターフェイス, アプリケーション, Word
自動的に生成された説明](../media/image43.png)

アプリケーションの動作確認としては以上ですが、ソースコードを参照します。

以下の特徴があります。

-   Server.py にFlaskなどのWebサーバーの起動をすることが必要
-   \@app_route
    アノテーションにより、どのエンドポイントで起動するかの明示指定が必要
-   Requirements.txt にFlaskおよび Gunicorn の依存関係指定が必要
-   Procfile に最終的な起動コマンドの指定が必要

次のハンズオンに進みます。
