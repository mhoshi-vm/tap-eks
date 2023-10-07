**⚠️　PHP は執筆時点、コミュニティ/Tanzu提供のビルドパックでは、[デフォルトでは watchexec とよばれるプロセス自動再起動の仕組みが不足している](https://github.com/paketo-buildpacks/php/issues/786)ため
一部ハンズオンが正しく実施することができません。このハンズオンでは、ビルドパックをカスタマイズを行い、LiveUpdate可能なコンテナを作成します。⚠️**

TERMINAL で作業します。

![テキスト
自動的に生成された説明](../media/image2.png)

自身のネームスペースの値を変数に設定してください。

```execute
export YOUR_NAMESPACE=`kubectl config view --minify -o jsonpath='{..namespace}'`
```
以下のコマンド実行します。

```execute
kubectl apply -f tap-php-recipes/php-simple-httpd-live/buildpack.yaml
```

以下のコマンドを実行して、ビルドバックが正常にロードされたことを確認します。

```execute
kubectl get clusterbuilder php-liveupdate
```

ライブアップデートの準備は以上です。
