
```execute
export ACCOUNT_ID=`aws sts get-caller-identity --query "Account" --output text`
export PREFIX="${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com/tappoc/workloads"
for i in hello-nodejs hello-nodejs-test-scan hello-vehicle hello-vehicle-with-db
do 
 if [[ -n $YOUR_NAMESPACE && -n $PREFIX ]]
 then
  aws ecr create-repository --repository-name $PREFIX/${i}-${YOUR_NAMESPACE}
 fi
done
```

以降、Editor で作業します。

![A screenshot of a computer Description automatically generated with
medium confidence](../media/image38.png)



IDEのセットアップは以上です。
