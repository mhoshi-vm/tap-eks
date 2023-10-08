ここまでの作業を一旦クリーンアップを行います。

TERMINAL で作業します。

![テキスト
自動的に生成された説明](../media/image2.png)

自身のネームスペースの値を変数に設定してください。

```execute
export YOUR_NAMESPACE=`kubectl config view --minify -o jsonpath='{..namespace}'`
```
以下のコマンド実行します。

以下のコマンドでワークロードを全て削除します。

```execute
kubectl delete workload `kubectl get workload -o=jsonpath={.items[*].metadata.name}`
```

以下のコマンドで全てのECRレジストリを削除します。

```execute
export PREFIX="tappoc/workloads"
for i in php-simple php-simple-httpd php-simple-unit-test php-simple-w-supported-bindings php-simple-w-custom-bindings php-simple-httpd-live
do 
 if [[ -n $YOUR_NAMESPACE && -n $PREFIX ]]
 then
  aws ecr delete-repository --force --region ap-northeast-1 --repository-name $PREFIX/${i}-${YOUR_NAMESPACE}
  aws ecr delete-repository --force --region ap-northeast-1 --repository-name $PREFIX/${i}-${YOUR_NAMESPACE}-bundle
 fi
done
```

DB のクレームを削除します。

```execute
tanzu service class-claim delete postgres-claim -y
```

Redis の構成情報も削除します。

```execute
kubectl delete -f ~/tap-php-recipes/php-simple-w-supported-bindings/redis.yaml 
```

以上で Platform Operator 編を終了します。