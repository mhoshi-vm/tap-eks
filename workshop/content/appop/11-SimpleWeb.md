シンプルなウェブアプリケーションをTAP経由でデプロイします。
メニューよりOpen Folder を選択します。

![Graphical user interface, application Description automatically
generated](../media/image40.png)

/home/eduk8s/tap-python-recipies/php-simple
を入力し、フォルダーを起動します。

左ペインで右クリックを行い、"Tanzu Apply Workload" を選択します。

![img.png](img.png)!

ワークロードがデプロイされるまで、2-3分待ちます。

ターミナルを起動して、エンドポイントのURLの確認および動作の確認をします。

```
kubectl get ksvc
```
![img_1.png](img_1.png)

webブラウザ経由で上記の URL を入力し、サービス内容を確認します。

![img_2.png](img_2.png)

アプリケーションの動作確認としては以上です。まずはシンプルなデプロイを確認しました。

次のハンズオンに進みます。
