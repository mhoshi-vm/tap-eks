
**⚠️ TAP では、VScode
Serverは正式にはサポートされていません。ただし個別の開発環境のセットアップは誤差が発生しやすいため、ここではコンテナ化されたVScode
Serverを利用します。なお、正式な開発IDEのセットアップ方法はマニュアルをご参照ください。⚠️**

TAPの開発の過程で、以下のコンテナイメージが作成されます。

![Diagram Description automatically
generated](../media/image37.png)

-   SourceCode Image :
    ローカルのディレクトリーをコンテナイメージに圧縮して、レジストリに登録されます。コンテナに命名規則はなく、複数アプリケーションで同じ名前のイメージを使いまわせます。なお、For
    Platform Operators 編にあったよう、"\--git-repo"
    フラグを指定した場合は直接Gitのレポジトリーが参照されるため、このイメージは作成されません。
-   Application Image :
    ソースコードをコンパイルおよび依存関係を含めたアプリケーションのイメージです。
-   Manifest Image: Kubernetes
    のマニフェストが含まれたイメージです。なお、これは後のハンズオンの手順にあるGitOpsの機能でデプロイした場合はこのイメージは作成されません。

AppOperator 編ではこの、"SourceCode Image"
を明示的に設定する必要があり、これは各Editorや端末ごとに設定します。

**⚠️　SourceCode Imageが将来不要になる予定です。⚠️**

Editor で作業します。

![A screenshot of a computer Description automatically generated with
medium confidence](../media/image38.png)

Tanzu Developer Tools の Extension Settings を選択します。
```
Tanzu Developer Tools -> Extension Settings -> User
```
Tanzu: Source Image は  **okddemo.azurecr.io/tap/source-codes**
にします。

![A screenshot of a computer Description automatically generated with
medium confidence](../media/image39.png)

最後に以下のコマンドを実行し、コンテナレジストリにログインします。

```execute
docker login okddemo.azurecr.io
```

- Username: okddemo
- Token: ＜パスワードは当日共有＞

IDEのセットアップは以上です。
