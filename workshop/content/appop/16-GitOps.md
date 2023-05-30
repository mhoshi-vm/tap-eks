TAPのデプロイを承認などで制御するGitOpsモードのハンズオンです。

**⚠️　Pull Request を作る機能は執筆時点では Github / Gitlab / Azure
Devops のみがサポート対象です。⚠️**

TMCにログインを行い、SupplyChain Basic を開きます。

![A screenshot of a computer Description automatically generated with
medium confidence](../media/image70.png){width="7.5in"
height="3.7090277777777776in"}

Commit_stragety を開き、pull_request に変更します。

![A screenshot of a computer screen Description automatically generated
with low confidence](../media/image71.png){width="7.5in"
height="3.4902777777777776in"}

変更後 Apply Changes を選択します。(**これを行なった段階で他のデプロイがうまく行かなくなります。**)

事前に取得したGithub
のユーザーとパスワードを設定します。(当日講師によって伝えられます。)

```
export GIT_USERNAME=USERNAME
export GIT_PASSWORD=PASSWORD
```

以下のコマンドを実行します。

```execute
cat <<EOF | kubectl apply -n -f-
apiVersion: v1
kind: Secret
metadata:
  name: git-ssh
  annotations:
    tekton.dev/git-0: https://github.com
type: kubernetes.io/basic-auth
stringData:
  username: ${GIT_USERNAME}
  password: ${GIT_PASSWORD}
EOF
```


以下のコマンドでSAにgitのキーを登録します。

```
kubectl patch -n $YOUR_NAMESPACE serviceaccount default -p "{\"secrets\":[{\"name\":\"git-ssh\"}]}"
```


Github上に任意のレポジトリを作成します。\
(readme file 作成にチェックを入れて作成します。)

![グラフィカル ユーザー インターフェイス, テキスト, アプリケーション,
メール
自動的に生成された説明](../media/image72.png){width="7.413572834645669in"
height="3.066294838145232in"}

VScode Server から Open Folder
を実行し、以下のディレクトリーを開きます。

-   /home/eduk8s/tap-python-recipies/python-simple-func-w-gitops/

![Graphical user interface, text, application Description automatically
generated](../media/image73.png){width="4.416666666666667in"
height="2.6805555555555554in"}

Workload.yaml を開きます。Gitops_respository_owner と
gitops_repository_name を正しいものにアップデートします。

![グラフィカル ユーザー インターフェイス, テキスト, アプリケーション
自動的に生成された説明](../media/image74.png){width="4.161551837270341in"
height="4.187082239720035in"}

** ⚠️　TAPでのGitOpsは上のようにWorkload個別で設定する他にクラスタ全体でデフォルト値を設定する方法があります。その場合うえのパラメータは不要になります。⚠️ **

左ペインより、Tanzu Apply Workloadを実行します。

![](../media/image75.png){width="2.458286307961505in"
height="2.933277559055118in"}

しばらくして、Supply Chains -\> py-gitops -\> Config Writer より Pull
Requestが成されていることを確認します。

![グラフィカル ユーザー インターフェイス, アプリケーション
自動的に生成された説明](../media/image76.png){width="7.322884951881015in"
height="3.741661198600175in"}

「APPROVE A REQUEST」 をクリックすることで、Github の pull request
画面に遷移しますので、\
Github 上から Merge pull request をします。

![グラフィカル ユーザー インターフェイス, テキスト, アプリケーション,
メール
自動的に生成された説明](../media/image77.png){width="6.518323490813648in"
height="4.8621806649168855in"}

マージとともに環境にデプロイがすすんだことを確認します。

![ダイアグラム
自動的に生成された説明](../media/image78.png){width="7.266583552055993in"
height="2.3031047681539807in"}

GitOpsのハンズオンは以上です。
