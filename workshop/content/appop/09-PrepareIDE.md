
```exeute
git clone https://github.com/mhoshi-vm/tap-php-recipes
```


```execute
export PREFIX="tappoc/workloads"
for i in php-simple php-simple-httpd php-simple-unit-test php-simple-w-supported-bindings php-simple-w-custom-bindings
do 
 if [[ -n $YOUR_NAMESPACE && -n $PREFIX ]]
 then
  aws ecr create-repository --region ap-northeast-1 --repository-name $PREFIX/${i}-${YOUR_NAMESPACE}
  aws ecr create-repository --region ap-northeast-1 --repository-name $PREFIX/${i}-${YOUR_NAMESPACE}-bundle
 fi
done
```

以降、Editor で作業します。

![A screenshot of a computer Description automatically generated with
medium confidence](../media/image38.png)



IDEのセットアップは以上です。
