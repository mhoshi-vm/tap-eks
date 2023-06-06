
以降の作業は、この画面を用いて実施していきます。

![グラフィカル ユーザー インターフェイス, テキスト
自動的に生成された説明](../media/image1.png)
出現したターミナルに以下のコマンドを実行します。これにより追加で必要なコンポーネントのインストールが行われます。

```execute
./install-from-tanzunet.sh
```

以下のコマンドを実行してサンプルのアプリケーションをダウンロードします。

```execute
git clone https://github.com/mhoshi-vm/tap-python-recipies
```

以下のコマンドを実行して、自身のNamespace名を確認します。**この値はログインユーザーごとに異なるものが設定されています。**

```execute
echo `kubectl config view --minify -o jsonpath='{..namespace}'`
```


ハンズオン環境がセットアップが完了しました。
