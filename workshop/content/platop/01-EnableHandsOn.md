
以降の作業は、この画面を用いて実施していきます。

![グラフィカル ユーザー インターフェイス, テキスト
自動的に生成された説明](../media/image1.png)
出現したターミナルに以下のコマンドを実行します。これにより追加で必要なコンポーネントのインストールが行われます。

```execute
./install-from-tanzunet.sh
```

以下のコマンドを実行して、自身のNamespace名を確認します。**この値はログインユーザーごとに異なるものが設定されています。**

```execute
echo `kubectl config view --minify -o jsonpath='{..namespace}'`
export YOUR_NAMESPACE=`kubectl config view --minify -o jsonpath='{..namespace}'`
```

今回は、Amazon ECR をコンテナレジストリにつかいます。
**執筆時点で、ECR が、イメージプッシュ時にレジストリを自動生成ができないという強い制約があります。
この点はコミュニティからも[強い機能追加](https://github.com/aws/containers-roadmap/issues/853)が依頼が発生しています。
いずれにせよ、このハンズオンでは、デプロイをするアプリケーションのコンテナレジストリを事前に作る必要があります。
この制約が煩わしく感じる場合は、現時点は他のコンテナレジストリを検討して下さい。**

以下のコマンドで、 ECR へのレジストリ追加を行います。

```execute
export ACCOUNT_ID=`aws sts get-caller-identity --query "Account" --output text`
export PREFIX="${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com/tappoc/workloads"
for i in hello-nodejs hello-nodejs-test-scan hello-vehicle hello-vehicle-with-db
do 
 if [[ -n $YOUR_NAMESPACE && -n $PREFIX ]]
 then
  aws ecr create-repository --repository-name $PREFIX/${i}-${YOUR_NAMESPACE}
  aws ecr create-repository --repository-name $PREFIX/${i}-${YOUR_NAMESPACE}-bundle
 fi
done
```


ハンズオン環境がセットアップが完了しました。
