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
for i in hello-nodejs hello-nodejs-test-scan hello-vehicle hello-vehicle-with-db
do 
 if [[ -n $YOUR_NAMESPACE && -n $PREFIX ]]
 then
  aws ecr delete-repository --force --repository-name $PREFIX/${i}-${YOUR_NAMESPACE}
  aws ecr delete-repository --force --repository-name $PREFIX/${i}-${YOUR_NAMESPACE}-bundle
 fi
done
```

以上で Platform Operator 編を終了します。