Developer NamespaceとよばれるTAPの作業ネームスペースを設定していきます。

TERMINAL で作業します。

![テキスト
自動的に生成された説明](../media/image2.png)

以下のコマンドを実行します。

```execute
./install-from-tanzunet.sh
```


自身のネームスペースの値を変数に設定してください。

```execute
export YOUR_NAMESPACE=`kubectl config view --minify -o jsonpath='{..namespace}'`
```
以下のコマンド実行します。

```execute
kubectl label namespaces ${YOUR_NAMESPACE} apps.tanzu.vmware.com/tap-ns=""
kubectl annotate ns ${YOUR_NAMESPACE} secretgen.carvel.dev/excluded-from-wildcard-matching-
```

ハンズオン用のデモアプリケーションをダウンロードします。

```exeute
git clone https://github.com/mhoshi-vm/tap-php-recipes
```

一部のコンテキストを一括書き換えを行います。

```execute
find tap-php-recipes -type f | xargs sed -i "s/php-apps/php-${YOUR_NAMESPACE}/g" 
```


事前にECSのレポジトリを作成します。

```execute
export PREFIX="tappoc/workloads"
for i in php-simple php-simple-httpd php-simple-unit-test php-simple-w-supported-bindings php-simple-w-custom-bindings php-simple-httpd-live
do 
 if [[ -n $YOUR_NAMESPACE && -n $PREFIX ]]
 then
  aws ecr create-repository --region ap-northeast-1 --repository-name $PREFIX/${i}-${YOUR_NAMESPACE}
  aws ecr create-repository --region ap-northeast-1 --repository-name $PREFIX/${i}-${YOUR_NAMESPACE}-bundle
 fi
done
```

後の手順に必要となる Postgres と Redis のインスタンスを作成します。

```execute
tanzu service class-claim create postgres-claim --class postgresql-unmanaged -p storageGB=5
```

最後に、For App Operator編で利用することとなる、開発者用のKubeconfig
ファイルを生成します。

```execute
TOKEN=`kubectl get secret app-editor-token -o jsonpath='{.data.token}' | base64 --d`
cp ~/.kube/config /opt/code-server/kubeconfig
export KUBECONFIG=/opt/code-server/kubeconfig
kubectl config set-credentials app-editor --token=$TOKEN
kubectl config set-context --current --user=app-editor
unset KUBECONFIG
```

**⚠️　この手順で作成した Kubeconfig
はサービスアカウントをもとに作成しましたが、[本来はOIDCユーザーなど認証がともなったユーザーで登録するべき](https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/1.3/tap/GUID-authn-authz-pinniped-install-guide.html)です。⚠️**

以降、Editor で作業します。

![A screenshot of a computer Description automatically generated with
medium confidence](../media/image38.png)


IDEのセットアップは以上です。
