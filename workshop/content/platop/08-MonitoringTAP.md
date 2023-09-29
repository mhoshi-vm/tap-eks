TAP のモニタリングについて記載します。
Kubernetes のモニタリングは一般的に以下の要素で構成されることが多いです。

- メトリクス： Kubernetes のクラスタで発生する全てのイベントなどを数値化したもの。一般的に Kubernetes の監視を行う上では、一番主体となる項目。
- ログ: Kubernetes の各コンテナから発せられるログを集約。一般的に Kubernetes では、情報量が多く、かつ定型化しにくいため、ログは初動につかうものではなく、問題判別に使うことが一般的である。
- トレース：アプリケーションでのリクエストの可視化を行うためのもの。難易度がたかいものの、アプリケーションの詳細な挙動を知るには重要な情報。

![img.png](../media/observ3.png)

この章では、モニタリングの中心になるメトリクスについて紹介します。
外部サイトですが、以下の情報を参考にしながら、実施を行います。

[Monitoring TAP With Prometheus And Grafana](https://vrabbi.cloud/post/monitoring-tap-with-prometheus-and-grafana/)

TAP の SupplyChain での各ステップが Kubernetes のオブジェクトであることを利用して、蓄積ツールである [Prometheus](https://prometheus.io/)、そして可視化ツールである [Grafana](https://grafana.com/) を使いビジュアルを追加していきます。

以下の手順に従いください。
まず、 Github から該当のコードをダウンロードします。

```execute
git clone https://github.com/vrabbi-tap/tap-kube-state-metrics
cd tap-kube-state-metrics
```

次にコードで URL をアップデートします。

```execute
sed -e 's/tap-demo.vrabbi.cloud/handson.tappoc.lespaulstudioplus.info/g' values-example.yaml > values.yaml
```

以下のコマンドで helm のチャートをインストールします。

```execute
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm upgrade --install tap-monitoring prometheus-community/kube-prometheus-stack -n monitoring --create-namespace -f values.yaml
```

しばらく待機のち、以下のURLにログインをします。

https://grafana.handson.tappoc.lespaulstudioplus.info

講師より操作を案内します。