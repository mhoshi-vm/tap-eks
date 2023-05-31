
先程までは、静的 Sevice
Toolkitサービスプロビジョニングについて紹介しました。バックエンドサービスは事前に
Platform Operator
チーム側で用意し、パスワード等の認証情報は抽象化される形で開発チームに
Resource
Claim情報として渡します。その後、開発チームからは事前に用意したResource
Claim を使って Workload
をデプロイしバックエンドサービスとつなげるのを実現できました。

ところが、Platform
Operatorがワンステップ"事前に用意する"が考慮点になりうります。本番環境など、慎重な設計をした外部リソースにはこの手段が望ましいと思いますが、検証やステージングにおいては、Platform
Operator チームがボトルネックになる考慮点がでてきます。

そこで、動的サービスプロビジョニングについて紹介します。TAP1.5
からはデータベースなどバックエンドサービスも含め開発チーム側からバックエンドサービスをデプロイし、Workloadに容易にバックエンドサービスにバインドできる機能を提供しています。

TERMINAL で作業します。

![テキスト
自動的に生成された説明](../media/image2.png)

自身のネームスペースの値を再度設定してください。

```execute
export YOUR_NAMESPACE=`kubectl config view --minify -o jsonpath='{..namespace}'`
```


今回はBitnami Services
経由でプリインストールされたバックエンドサービスを利用します。以下のコマンドで利用できるサービスを確認します。

```execute
tanzu service class list
```

今回は postgresql
を利用するため、下記のコマンドを実行し利用できるバックエンドサービスのパラメータを確認します。


```execute
tanzu service class get postgresql-unmanaged
```


![テキスト
自動的に生成された説明](../media/image23.png)

上記の storageGBはDB容量の単位を指しており、今回は 5GB容量の
DBを使いたいので、下記のコマンドを実行して\
class claim を作成します。

```execute
tanzu service class-claim create ${YOUR_NAMESPACE}-claim --class postgresql-unmanaged -p storageGB=5
```

![](../media/image24.png)

また、下記のコマンドを実行して、class claim の作成状況を確認します。

```execute
tanzu services class-claims get ${YOUR_NAMESPACE}-claim  
```


![A computer screen with white text Description automatically generated
with low confidence](../media/image25.png)\
storageGB: 5\
Ready: True

の情報を確認できます。

この状態で、静的プロビジョニングで利用していた Workload
を再度デプロイします。**ResourceClaimではなくClassClaimを指定します**。

```execute
tanzu apps workload apply hello-vehicle-with-db-dynamic \
  --app hello-vehicle-with-db \
  --git-repo https://github.com/making/vehicle-api \
  --git-branch main \
  --type web \
  --build-env BP_JVM_VERSION=17 \
  --service-ref vehicle=services.apps.tanzu.vmware.com/v1alpha1:ClassClaim:${YOUR_NAMESPACE}-claim \
  --annotation autoscaling.knative.dev/minScale=1 \
  -y
```


下記のコマンドを実行し、hello-vehicle-with-db
Workloadがデプロイされているのを確認します。

```execute
tanzu apps wld list
```


![A screen shot of a computer Description automatically generated with
low confidence](../media/image26.png)

下記のコマンドでURL を確認し、サービスにアクセスしてみます。

```execute
kubectl get ksvc
```

![](../media/image27.png)

```execute
curl -k https://hello-vehicle-with-db-dynamic.${YOUR_NAMESPACE}.tap.ok-tap.net/vehicles  | jq .
```

![テキスト
自動的に生成された説明](../media/image28.png)

今回はBitnami Services
経由でプリインストールされたバックエンドサービスを利用して self service
の形でDB の作成をClass claim
を作成する形で実現しました。バックエンドサービスとして動いている
postgresql は下記のコマンドで確認できます。

まず、Namespace を確認し、該当 namespace をPod を確認します。

```execute
kubectl get ns  | grep ${YOUR_NAMESPACE}-claim
```

![](../media/image29.png)

該当Namespaceのpodを確認すると、postgresql が稼働しています。

![](../media/image30.png)

Bitnami Services
以外にも動的サービスを登録することで様々なバックエンドサービスを self
serviceで利用可能です。Bitnami Services
経由でプリインストールされたバックエンドサービス以外を動的プロビジョニングサービスとして利用したい場合は、個別にサービスを登録する必要があります。関連手順は下記です。\
\
<https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/1.5/tap/services-toolkit-tutorials-setup-dynamic-provisioning.html>

Service Toolkit の動的プロビジョニングの手順の完了です。
