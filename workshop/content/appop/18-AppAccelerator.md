ここからは TAP のカタログ機能である Application Accelerator
について紹介します。

この機能を使うことで、アプリケーションの標準テンプレート用意することできます。詳細は以下のブログも参考ください。

[Tanzu Application Platformでアプリの雛形をつくろう：Application
Accelerator](https://blogs.vmware.com/vmware-japan/2022/02/lets-build-catalogs-tanzu-application-platform-appaccelerator.html)

まず、既存の app accelerator を確認します。

```execute
tanzu accelerator list
```


手動で新しいApplication Accelerators
テンプレートを登録します。Github 上の Repositoryを使って App Accelerator に登録します。

```execute
GIT_REPOSITORY_URL=https://github.com/mhoshi-vm/tap-php-recipes
GIT_REPOSITORY_BRANCH=main
tanzu accelerator create tap-php-recipies --git-repository ${GIT_REPOSITORY_URL} --git-branch ${GIT_REPOSITORY_BRANCH}
```

<https://github.com/mhoshi-vm/tap-php-recipies/accelerator.yaml>

上記のファイルがApplication Accelerator を登録するための YAML
ファイルです。以下のような項目から構成されています。

-   displayName : TAP GUI -\> Generate Acceleratorsで表示される名前
-   description： より詳細な説明
-   iconUrl: アイコン画像を指す URL
-   options: (inputType: select) ドロップダウンリストを定義
-   engine:
    ドロップダウンリストで選択された内容に基づいて定義されたアクションを実行(今回の場合は、githubリポジトリのサブフォルダを含める)

tanzu cli とTAP GUI
からどのように表示されているかを確認します。再度、app accelerator
を確認します。

```execute
tanzu accelerator list
```

tap-php-recipies が登録されているのを確認できます。

![img_16.png](../media/img_16.png)

TAP GUI からも新規で登録した tap-php-recipiesを確認します。

![img_17.png](../media/img_17.png)

CHOOSE ボタンをクリックし、Generate Accelerators 画面でChoose php
Framework ドロップダウンリストを展開します。

![img_18.png](../media/img_18.png)

NEXT ボタン -\> GENERATE ACCELERATOR ボタンを選択します。
EXPLORE ZIP FILE を選択し、生成されたテンプレートの中身を確認します。TAP GUIに認識が必要なラベル名などが変わったことを確認します。
![img_19.png](../media/img_19.png)

このように、標準テンプレートを用意し、Application
Accelerator に登録することで、基盤に関わるパラメーターを意識することなく、開発に着手できます。

Application Acceleratorのデモは以上です。
