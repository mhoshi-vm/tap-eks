#!/bin/bash
set -e
set -x
if [ "${TANZUNET_TOKEN}" != "" ]; then
   pivnet login --api-token=${TANZUNET_TOKEN}

   if [ "${TAP_VERSION}" == "" ]; then
     DEFAULT_TAP_VERSION=1.6.3
     TAP_VERSION=${DEFAULT_TAP_VERSION}
   fi
   pivnet download-product-files --product-slug='tanzu-application-platform' --release-version=${TAP_VERSION} --glob='*.vsix'
   for vsix in $(ls *.vsix);do
       code-server --install-extension ${vsix}
   done
   rm -f *.vsix
   tanzu plugin install --group vmware-tap/default:v${TAP_VERSION}
fi
