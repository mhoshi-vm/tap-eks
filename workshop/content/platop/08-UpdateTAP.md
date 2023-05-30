
Tanzu Mission Control （TMC）を使用し、TAP を1.5.0 から1.5.1
にアップグレードする手順を紹介します。

TMC からOpenShift クラスタを選択し、Tanzu Repositories を選択します。

![A screenshot of a computer Description automatically generated with
medium confidence](../media/image31.png){width="3.888888888888889in"
height="2.7222222222222223in"}

tap-package を選択して、Editを選択します。プロンプトの値を1.5.0 から
1.5.1 に変更します。

![A screenshot of a computer Description automatically generated with
medium confidence](../media/image32.png){width="7.5in"
height="4.2659722222222225in"}

上部メニューのAdd-ons
を選択します。表示されたインストール済みパッケージの中から、tap
を選択します。

![グラフィカル ユーザー インターフェイス, アプリケーション, メール
自動的に生成された説明](../media/image33.png){width="7.5in"
height="3.575in"}

画面上部のACTOINS から、Change Desired
Versionを選択します。バージョン1.5.1 をクリックし、CONFIRM
を選択します。

![グラフィカル ユーザー インターフェイス, アプリケーション
自動的に生成された説明](../media/image34.png){width="7.5in"
height="3.109027777777778in"}

確認画面でCONFIRM選択します。

![グラフィカル ユーザー インターフェイス, アプリケーション
自動的に生成された説明](../media/image35.png){width="7.5in"
height="3.142361111111111in"}

認画Status がSucceeded
になるまで待ちます。アップグレードの完了まで5分程度かかります。

![グラフィカル ユーザー インターフェイス, アプリケーション, メール
自動的に生成された説明](../media/image36.png){width="7.5in"
height="3.6152777777777776in"}

以上でアップグレードが完了しました。なお、これまでのデプロイされたインスタンスもこのアップデートによってどうなったかをご確認ください。\
(ハンズオン中に解説)
