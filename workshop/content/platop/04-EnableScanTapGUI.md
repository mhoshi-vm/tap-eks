

現時点では、tap gui
のスキャニングを見ると以下のようにエラーになってしまいます。

<https://tap-gui.tap.ok-tap.net/security-analysis>

![A screenshot of a computer Description automatically generated with
medium confidence](../media/image9.png){width="7.5in"
height="4.652083333333334in"}

TAP GUI でのスキャニングを有効にするために、以下の追加の手順が必要です。

TERMINAL で作業します。

![テキスト
自動的に生成された説明](../media/image2.png){width="5.712390638670167in"
height="2.458286307961505in"}

以下のコマンドを入力します。

```execute
kubectl get secrets metadata-store-read-write-client -n metadata-store -o jsonpath=\"{.data.token}\" \| base64 -d
```

出力される値を保存します。再びTMCにログインをして、TAP
の設定ファイルを開きます。

以下のブロックを追加して、Apply します。

```
tap_gui:
  app_config:
    proxy:
      /metadata-store:
        target: https://metadata-store-app.metadata-store:8443/api/v1
        changeOrigin: true
        secure: false
        headers:
          Authorization: "Bearer <前手順で確認したTOKEN>"
          X-Custom-Source: project-star
```


![A screenshot of a computer Description automatically generated with
low confidence](../media/image10.png){width="7.5in"
height="3.140972222222222in"}

Apply 後、再度スキャニング画面をみると該当の結果がみれると思います。

<https://tap-gui.tap.ok-tap.net/security-analysis>

![A screenshot of a computer Description automatically generated with
medium confidence](../media/image11.png){width="7.5in"
height="3.7680555555555557in"}

TAP-GUI のスキャニングの有効化は以上です。
