
Tanzu Mission Control （TMC）を使用し、TAP を1.5.0 から1.5.1
にアップグレードする手順を紹介します。
TMC からOpenShift クラスタを選択し、Tanzu Repositories を選択します。

![A screenshot of a computer Description automatically generated with
medium confidence](../media/image31.png)

tap-package を選択して、Editを選択します。プロンプトの値を1.5.0 から
1.5.1 に変更します。

![A screenshot of a computer Description automatically generated with
medium confidence](../media/image32.png)

上部メニューのAdd-ons
を選択します。表示されたインストール済みパッケージの中から、tap
を選択します。

![グラフィカル ユーザー インターフェイス, アプリケーション, メール
自動的に生成された説明](../media/image33.png)

画面上部のACTOINS から、Change Desired
Versionを選択します。バージョン1.5.1 をクリックし、CONFIRM
を選択します。

![グラフィカル ユーザー インターフェイス, アプリケーション
自動的に生成された説明](../media/image34.png)

確認画面でCONFIRM選択します。

![グラフィカル ユーザー インターフェイス, アプリケーション
自動的に生成された説明](../media/image35.png)

認画Status がSucceeded
になるまで待ちます。アップグレードの完了まで5分程度かかります。

![グラフィカル ユーザー インターフェイス, アプリケーション, メール
自動的に生成された説明](../media/image36.png)

以上でアップグレードが完了しました。
