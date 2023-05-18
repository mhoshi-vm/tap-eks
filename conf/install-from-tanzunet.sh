#!/bin/bash
set -e
set -x
if [ "${TANZUNET_TOKEN}" != "" ]; then
   pivnet login --api-token=${TANZUNET_TOKEN}

   if [ "${TAP_VERSION}" == "" ]; then
     DEFAULT_TAP_VERSION=1.5.1
     TAP_VERSION=${DEFAULT_TAP_VERSION}
   fi
   pivnet download-product-files --product-slug='tanzu-application-platform' --release-version=${TAP_VERSION} --glob='*.vsix'
   for vsix in $(ls *.vsix);do
       code-server --install-extension ${vsix}
   done
   rm -f *.vsix
 
   pivnet download-product-files --product-slug='tanzu-application-platform' --release-version=${TAP_VERSION} --glob='tanzu-framework-linux-amd64-*.tar'
 
   export TANZU_CLI_NO_INIT=true
   tar xvf tanzu-framework-*.tar
   mkdir -p $HOME/.local/bin
   install cli/core/*/tanzu-core-*_amd64 $HOME/.local/bin/tanzu
   $HOME/.local/bin/tanzu plugin install --local cli all
   rm -f tanzu-framework-*.tar
   rm -rf cli
fi
