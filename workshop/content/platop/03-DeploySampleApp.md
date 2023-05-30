

Developer
Namespaceの準備ができたので引き続き、サンプルアプリケーションをデプロイします。

TERMINAL で作業します。

![テキスト
自動的に生成された説明](../media/image2.png){width="5.712390638670167in"
height="2.458286307961505in"}

自身のネームスペースの値を再度設定してください。

```execute
export YOUR_NAMESPACE=`kubectl config view --minify -o jsonpath='{..namespace}'`
```

以下をTerminalより実行してください。

```execute
tanzu apps workload apply hello-nodejs \
  --app hello-nodejs \
  --git-repo https://github.com/making/hello-nodejs \
  --git-branch master \
  --type web \
  -y
```

待ち時間が発生するので続いて、テスト・スキャンありのワークロードを作成します。赤字により、テストおよびスキャンが行われます。

```execute
tanzu apps workload apply hello-nodejs-test-scan \
  --app hello-nodejs \
  --git-repo https://github.com/making/hello-nodejs \
  --git-branch master \
  --type web \
  --label apps.tanzu.vmware.com/has-tests=true \
  -y
```

以下のコマンドで、デプロイが完了したことを確認します。

```execute
tanzu apps workload list
```


![A picture containing text, screenshot, font Description automatically
generated](../media/image5.png){width="7.5in"
height="1.148611111111111in"}

以下のコマンドで、Workload の URLを確認します。
(curlコマンドで叩いてください)

```execute
kubectl get ksvc
```

![](../media/image6.png){width="7.5in" height="0.8993055555555556in"}

curl -k コマンドで上記のURL にアクセスしてみます。

```execute
curl -k https://hello-nodejs.${YOUR_NAMESPACE}.tap.ok-tap.net
curl -k https://hello-nodejs-test-scan.${YOUR_NAMESPACE}.tap.ok-tap.net
```

![](../media/image7.png){width="7.5in" height="0.5951388888888889in"}

サンプルアプリケーションのデプロイは以上ですが、以下のコマンドなどを行いながら、ワークロードを確認してください。

-   tanzu apps workload get \<対象のワークロード\>

-   TAP GUI での比較

![グラフィカル ユーザー インターフェイス, テキスト, アプリケーション自動的に生成された説明](../media/image8.png){width="7.5in"height="2.2472222222222222in"}
