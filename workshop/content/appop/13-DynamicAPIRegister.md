SwaggerのエンドポイントをもったアプリケーションをTAP
GUIに集約するハンズオンです。

Open Folder から以下のディレクトリーを開きます。

-   /home/eduk8s/tap-python-recipies/python-simple-rest-w-swagger/

![Graphical user interface, text, application Description automatically
generated](../media/image49.png)

左ペインより、"Tanzu Apply Workload" を実行します。デプロイ完了後、TAP
GUIにログインを行います。
左ペインより、APIsを選択すると、デプロイしたアプリケーションの情報が確認できます。

![グラフィカル ユーザー インターフェイス, アプリケーション
自動的に生成された説明](../media/image50.png)

APIの定義情報も確認が行えます。

![グラフィカル ユーザー インターフェイス, テキスト, アプリケーション,
メール 自動的に生成された説明](../media/image51.png)

ソースコードを確認すると以下のことがわかります。

-   Requirments.txt にAPIドキュメントを生成する
    flask-restxが定義されていること
-   Workload.yaml に以下の特徴があること
    -   apis.apps.tanzu.vmware.com/register-api:
        \"true\"が定義されていること
    -   autoscaling.knative.dev/minScale: \"1\"
        により、最小スケール数が1に設定されていること
    -   api_descriptor以下にAPIの登録情報が記載されていること

動的API登録の確認は以上です。
