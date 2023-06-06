TAPのビルドの段階で、テストやスキャンを行うハンズオンを行います。

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
kubectl get pipeline developer-defined-tekton-pipeline -o yaml
```

出力の以下に注目します。

```
spec:
  tasks:
  - name: test
    taskSpec:
      metadata: {}
      spec: null
      steps:
      - image: alpine
        name: test
        resources: {}
        script: echo hello
```


現状は特に何も設定しない指定したパイプラインが登録されています。TAPでは、ビルドクラスタ時の品質ゲートの役割を設定することが可能です。ここでは、スクリプトをアップデートします。

以下のコマンド実行してください。

```execute
kubectl label namespaces ${YOUR_NAMESPACE} handson.tanzu.japan.com/python="true"
```

Namespaceに特定のラベルを設定することにより、Developer Namespace が python
の値を識別して、それ専用のパイプラインが登録されます。今回の環境では以下の該当行が適用されます。

https://github.com/mhoshi-vm/tap-openshift-jp/blob/main/dev_namespace/overlay.yaml#L7-L57

実行後(最大10分)まち、以下のコマンドを実行してください。

```execute
kubectl get pipeline developer-defined-tekton-pipeline -o yaml
```

spec以下が以下のようになったことを確認します。

```
spec:
  params:
  - name: source-url
    type: string
  - name: source-revision
    type: string
  tasks:
  - name: test-coverage
    params:
    - name: source-url
      value: $(params.source-url)
    - name: source-revision
      value: $(params.source-revision)
    taskSpec:
      metadata: {}
      params:
      - name: source-url
        type: string
      - name: source-revision
        type: string
      spec: null
      steps:
      - image: okddemo.azurecr.io/python:latest
        name: test
        resources: {}
        script: |-
          set -ex
          whoami
          cd `mktemp -d`
          export HOME=$PWD
          export PATH=$HOME/.local/bin:$PATH

          wget -qO- $(params.source-url) | tar xvz -m
          pip install -r requirements.txt --user
          pip show pytest || {
            echo "###\nWarning: Pytest is missing in your requirements\n###";
            pip install pytest --user
          }
          pip show coverage || {
            echo "###\nWarning: Coverage is missing in your requirements\n###";
            pip install coverage --user
          }
          pytest
          coverage run -m pytest .
          coverage report -m
```


更新の完了が確認できたら再び Editor を開きます。

Open Folder から以下のフォルダーを開きます。

-   /home/eduk8s/tap-python-recipies/python-simple-func-w-test/

![グラフィカル ユーザー インターフェイス, テキスト, アプリケーション
自動的に生成された説明](../media/image47.png)

Workload.yaml を開き、` apps.tanzu.vmware.com/has-tests: true`
が指定されていることを確認します。これによりテストおよびスキャンを実行するSupplyChainが実行されます。

右クリック "Tanzu Apply Workload" を実行します。\
2-3分後アプリケーションのデプロイが完了したら、TAP-GUIにログインを行います。

![グラフィカル ユーザー インターフェイス, テキスト, アプリケーション
自動的に生成された説明](../media/image48.png)

この中でのpy-func-test を確認してください。なお、元となるソースコードについても以下の特徴がある点をご確認ください。

-   関数に対してのみテストを書くため、テストがシンプルで書きやすい
-   Requirments.txt に自由に依存関係を含めることができる

テスト&スキャンのスクリプトは以上です。
