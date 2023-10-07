TAP GUI にてここまでデプロイしてきたものをみてみます。
TAP GUI のバックエンドになっているBackstageが得意とするものが、ツールでのビューではなく、アプリを中心としたビューを提供することです。

![img_5.png](../media/img_5.png)

ここでは簡単ながら Backstage を体感します。TAP GUI にログインを行い、以下に進みます。

![img_6.png](../media/img_6.png)

この中の "Register Entity"　を選択します。
Select URL の中に以下を入力します。

```
https://github.com/mhoshi-vm/tap-eks/blob/main/backstage/catalog-tap-${YOUR_NAMESPACE}.yaml
```
![img_12.png](../media/img_12.png)

登録ののち、TAPのトップ画面に該当のアプリケーションが存在することを確認します。

![img_13.png](../media/img_13.png)

自身の該当のアプリケーションを展開して、Runtime Resource タブを選択します。
すると、自身のデプロイしたアプリケーションに関係したリソースが一覧が取得されます。

![img_14.png](../media/img_14.png)

ここから pod のログをみることができます。
![img_15.png](../media/img_15.png)

Backstage は複数のリソースをネームスペースとはさらに異なり、縦断的なビューを提供することが可能です。
Kubernetes の場合、これはラベルによって制御されています。

TAP GUIの確認は以上です。