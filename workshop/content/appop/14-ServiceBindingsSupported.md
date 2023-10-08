PHP ビルドパックは、セッション管理を行うための、memcached もしくは redis 互換のデータストアと透過的に接続する方法を持ち合わせています。
このハンズオンでは、その内容を検証します。詳細は以下のマニュアルもご参照ください。

https://docs.vmware.com/en/VMware-Tanzu-Buildpacks/services/tanzu-buildpacks/GUID-php-php-buildpack.html#enable-a-session-handler-via-service-bindings

**これから行う操作は開発者ロール(app-editor)では編集不可なので、Editorではなく、Terminal
で作業します。**

![テキスト
自動的に生成された説明](../media/image2.png)

自身のネームスペースの値を再度設定してください。

```execute
export YOUR_NAMESPACE=`kubectl config view --minify -o jsonpath='{..namespace}'`
```

以下のコマンドを実行してください。

```execute
kubectl apply -f ~/tap-php-recipes/php-simple-w-supported-bindings/redis.yaml 
```

まずは redis がデプロイされたことを確認します。

```execute
kubectl get classclaim redis-claim
```

さらにしばらくしたら、redis の認証情報を含んだ Secret ファイルが自動生成されていることを確認します。

```execute
kubectl get secret claim-to-php-redis-session -o yaml
```

更新の完了が確認できたら再び Editor を開きます。
Open Folder から以下のディレクトリーを開きます。

-   /home/eduk8s/tap-php-recipies/php-simple-rest-w-supported-bindings

![Graphical user interface, text, application Description automatically
generated](../media/image49.png)


左ペインより、"Tanzu Apply Workload" を実行します。
デプロイ後以下のコマンドで、たちがったインスタンス数を確認します。(通常このタイミングでは、3つのインスタンスが起動している状態になるはず。)

```
kubectl get po | grep php-simple-w-supported-bindings
```

以下のコマンドでURLを確認します。

```
kubectl get ksvc | grep php-simple-w-supported-bindings
```

URL 確認後、ブラウザでログインを行います。このとき、アクセスカウンタがたまっていくことを確認します。
ステートをもたない３つのインスタンスがredisのセッションストアを利用して、セッションを共有できている状態がわかります。

さらに、コンテナの中のファイルを確認します。以下のコマンドを確認すると、redisのセッション情報が記載されていることがわかります。

```execute
kubectl exec -it `kubectl get po -l serving.knative.dev/configuration=php-simple-w-supported-bindings -o=jsonpath='{.items[].metadata.name}'` cat /layers/tanzu-buildpacks_php-redis-session-handler/php-redis-config/php-redis.ini 
```

ソースコードを確認すると以下のことがわかります。

-   Workload.yaml に以下の特徴があること
    -   SERVICE_BINDING_ROOT 環境変数が存在すること
    -   autoscaling.knative.dev/minScale: \"3\"
        により、最小スケール数が3に設定されていること
    -   bind 以下に指定したRedisのセッションストアが登録されること

Service Bindings 検証(サポート対象)は以上です。
