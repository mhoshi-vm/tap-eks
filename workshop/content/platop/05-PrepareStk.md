
TERMINAL で作業します。

![テキスト
自動的に生成された説明](../media/image2.png)

Service Toolkit
へのSecretの参照権限を与えます。

```execute
cat <<EOF | kubectl apply -f-
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: resource-claims-secret
  labels:
    servicebinding.io/controller: "true" # IMPORTANT
rules:
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["get", "list", "watch"]
EOF
```

以下を実行して、service classの現在の一覧を確認します。

```execute
tanzu service class list
```

![テキスト
自動的に生成された説明](../media/image12.png)

手動で Service Class を作ります。以下のコマンドを実行します。

```execute
cat <<EOF | kubectl apply -f-
apiVersion: services.apps.tanzu.vmware.com/v1alpha1
kind: ClusterInstanceClass
metadata:
  name: postgres
spec:
  description:
    short: It's a PostgresSQL !
  pool:
    kind: Secret
    labelSelector:
      matchLabels:
        postgres: "true"
EOF
```


tanzu service class list
のコマンドを実行すると、追加されたClassが表示されます。

![テキスト
自動的に生成された説明](../media/image13.png)

database-ns という Namespace を作成します。

```execute
kubectl create ns database-ns
```


ResourceClaimPolicyを作り、複数Namespaceから参照できるようにします。以下を実行します。

```execute
cat <<EOF | kubectl apply -f-
apiVersion: services.apps.tanzu.vmware.com/v1alpha1
kind: ResourceClaimPolicy
metadata:
  name: secrets-cross-namespace
  namespace: database-ns
spec:
  consumingNamespaces:
  - '*'
  subject:
    kind: Secret
    group: ""
EOF
```

Service Toolkit の準備は以上です。
