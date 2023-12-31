
Developer NamespaceとよばれるTAPの作業ネームスペースを設定していきます。

TERMINAL で作業します。

![テキスト
自動的に生成された説明](../media/image2.png)

自身のネームスペースの値を変数に設定してください。

```execute
export YOUR_NAMESPACE=`kubectl config view --minify -o jsonpath='{..namespace}'`
```
以下のコマンド実行します。

```execute
kubectl get secret registries-credentials
kubectl get pipeline
kubectl get scanpolicy
```

以下のように現状は何も存在しないこと("No resource found")
になっていることを確認してください。

![A black screen with white text Description automatically generated
with low confidence](../media/image3.png)

サービスアカウントのIRSAの設定も確認します。以下のコマンドが出力がないことをご確認ください。

```execute
kubectl get sa default -o jsonpath='{.metadata.annotations.eks\.amazonaws\.com/role-arn}' 
```

Developer Namespace
を有効にしてききます。以下のコマンド実行してください。

```execute
kubectl label namespaces ${YOUR_NAMESPACE} apps.tanzu.vmware.com/tap-ns=""
kubectl annotate ns ${YOUR_NAMESPACE} secretgen.carvel.dev/excluded-from-wildcard-matching-
```

しばらくまつと、以下のように、先ほど失敗したコマンドが成功するようになります。

```execute
kubectl get secret registries-credentials
kubectl get pipeline
kubectl get scanpolicy
```

サービスアカウントのIRSAの設定も確認します。IAM Roleが出現することを確認してください。

```execute
kubectl get sa default -o jsonpath='{.metadata.annotations.eks\.amazonaws\.com/role-arn}' 
```


![A screenshot of a computer program Description automatically generated
with medium confidence](../media/image4.png)

Developer Namespace
は特定のラベル("apps.tanzu.vmware.com/tap-ns=\"\")を設定されたネームスペースに以下を設定していきます。

-   インストール時に "Export to All Namespace"
    に設定したコンテナレジストリのユーザー名、パスワードを
    registries-credentials として配布

-   インストール時に設定したnamespace provisioner の値に対応した git
    レポジトリからのマニュフェスト。本ハンズオンでは、以下のURLより取得\
    <https://github.com/mhoshi-vm/tap-eks/tree/main/dev_namespace>

より詳細は以下をご参照ください。

[開発チームが使う Namespace の払い出し作業を楽にしよう -- Tanzu
Application Platform 1.4 から提供する Namespace Provisioner
機能とは](https://blogs.vmware.com/vmware-japan/2023/03/namespace-provision.html)

Developer　ネームスペースの作成は以上です。
