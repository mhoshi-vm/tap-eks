#!/bin/bash
set -e
if [ ! -f $HOME/firstrun ];then
  if [ ! -f $HOME/.pivnetrc ];then
      if [ "${TANZUNET_TOKEN}" != "" ]; then
         set -x
         pivnet login --api-token=${TANZUNET_TOKEN}
         DEFAULT_TAP_VERSION=1.5.1
         TAP_VERSION=${DEFAULT_TAP_VERSION}
         pivnet download-product-files --product-slug='tanzu-application-platform' --release-version=${TAP_VERSION} --glob='*.vsix'
         for vsix in $(ls *.vsix);do
             code-server --install-extension ${vsix}
         done
         rm -f *.vsix
       
         set -x
         pivnet download-product-files --product-slug='tanzu-application-platform' --release-version=${TAP_VERSION} --glob='tanzu-framework-linux-amd64-*.tar'
         set +x
       
         export TANZU_CLI_NO_INIT=true
         tar xvf tanzu-framework-*.tar
         mkdir -p $HOME/.local/bin
         install cli/core/*/tanzu-core-*_amd64 $HOME/.local/bin/tanzu
         $HOME/.local/bin/tanzu plugin install --local cli all
         rm -f tanzu-framework-*.tar
         rm -rf cli
         touch $HOME/firstrun
      fi
  fi
fi

