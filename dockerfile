
# kubectl get ds -n learningcenter learningcenter-prepull -o=jsonpath="{.spec.template.spec.initContainers[0].image}"
FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:c184e9399d2385807833be0a9f1718c40caa142b6e1c3ddf64fa969716dcd4e3

# # All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root

# Visual Studio Code Extentions
ENV CS_VERSION=4.12.0
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --version=${CS_VERSION}
RUN cp -rf /usr/lib/code-server/* /opt/code-server/
RUN rm -rf /usr/lib/code-server /usr/bin/code-server

USER 1001

ENV VSCODE_USER /home/eduk8s/.local/share/code-server/User
ENV VSCODE_EXTENSIONS /home/eduk8s/.local/share/code-server/extensions

RUN code-server --install-extension redhat.java
RUN code-server --install-extension vscjava.vscode-java-debug
RUN code-server --install-extension vscjava.vscode-java-test
RUN code-server --install-extension vscjava.vscode-maven
RUN code-server --install-extension vscjava.vscode-java-dependency
RUN code-server --install-extension pivotal.vscode-spring-boot
RUN code-server --install-extension vscjava.vscode-spring-initializr
RUN code-server --install-extension vscjava.vscode-spring-boot-dashboard
RUN code-server --install-extension redhat.vscode-yaml
RUN code-server --install-extension adashen.vscode-tomcat
RUN code-server --install-extension dgileadi.java-decompiler

# All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root

# Misc
RUN sudo apt-get update && sudo apt-get install --no-install-recommends -y \
    jq \
    curl \
    unzip \
    wget 

# Liberica JDK
ENV JDK_VERSION=17.0.7+7
RUN wget -q -O OpenJDK.tar.gz https://download.bell-sw.com/java/${JDK_VERSION}/bellsoft-jdk${JDK_VERSION}-linux-amd64.tar.gz && \
    tar xzf OpenJDK.tar.gz && \
    sudo mv jdk* /opt/ && \
    rm -f OpenJDK.tar.gz && \
    echo "export JAVA_HOME=$(dirname /opt/jdk-*/bin/)" | sudo tee -a /etc/profile.d/00-java.sh > /dev/null && \
    echo 'export JRE_HOME=${JAVA_HOME}' | sudo tee -a /etc/profile.d/00-java.sh > /dev/null && \
    echo 'export PATH=${PATH}:${JAVA_HOME}/bin' | sudo tee -a /etc/profile.d/00-java.sh > /dev/null
RUN chmod +x /etc/profile.d/00-java.sh

# Tanzu
ENV TANZU_VERSION=0.29.0
RUN wget -q https://github.com/vmware-tanzu/tanzu-framework/releases/download/v${TANZU_VERSION}/tanzu-framework-linux-amd64.tar.gz && \
    tar xzvf tanzu-framework-linux-amd64.tar.gz && \
    sudo install cli/core/v${TANZU_VERSION}/tanzu-core-linux_amd64 /usr/local/bin/tanzu && \
    tanzu plugin install --local cli all && \
    rm -fr tanzu-framework* cli

ENV TANZU_APPS_CLI_PLUGIN_VERSION=0.11.1
RUN wget -q https://github.com/vmware-tanzu/apps-cli-plugin/releases/download/v${TANZU_APPS_CLI_PLUGIN_VERSION}/tanzu-apps-plugin-linux-amd64-v${TANZU_APPS_CLI_PLUGIN_VERSION}.tar.gz && \
    mkdir tanzu-apps-plugin && \
    tar xzvf tanzu-apps-plugin-linux-amd64-v${TANZU_APPS_CLI_PLUGIN_VERSION}.tar.gz -C tanzu-apps-plugin && \
    tanzu plugin install apps --local tanzu-apps-plugin --version v${TANZU_APPS_CLI_PLUGIN_VERSION} && \
    rm -fr tanzu-apps-plugin*

# Maven
ENV MAVEN_VERSION=3.9.2
RUN wget -q -O maven.tar.gz http://ftp.riken.jp/net/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar xzf maven.tar.gz && \
    sudo mv apache-maven-* /opt/ && \
    rm -f maven.tar.gz && \
    echo "export MAVEN_HOME=/opt/apache-maven-${MAVEN_VERSION}" | sudo tee -a /etc/profile.d/01-maven.sh > /dev/null && \
    echo 'export PATH=${PATH}:${MAVEN_HOME}/bin' | sudo tee -a /etc/profile.d/01-maven.sh > /dev/null
RUN chmod +x /etc/profile.d/01-maven.sh

# Kubectl
ENV KUBECTL_VERSION 1.27.1
RUN wget -q -O kubectl "https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    sudo install kubectl /usr/local/bin/ && \
    rm -f kubectl*

# Carvel
RUN wget -O- https://carvel.dev/install.sh | bash

# Tilt
ENV TILT_VERSION=0.32.3
RUN wget -q -O tilt.tar.gz https://github.com/tilt-dev/tilt/releases/download/v${TILT_VERSION}/tilt.${TILT_VERSION}.linux.x86_64.tar.gz && \
    tar xzf tilt.tar.gz && \
    sudo install tilt /usr/local/bin/ && \
    rm -rf tilt*

# pivnet
ENV PIVNET_VERSION 3.0.1
RUN wget -q -O pivnet https://github.com/pivotal-cf/pivnet-cli/releases/download/v${PIVNET_VERSION}/pivnet-linux-amd64-${PIVNET_VERSION} && \
    sudo install pivnet /usr/local/bin/ && \
    rm -f pivnet*

# oc command
ENV OC_VERSION=4.12.0-0.okd-2023-04-16-041331
RUN wget https://github.com/okd-project/okd/releases/download/${OC_VERSION}/openshift-client-linux-${OC_VERSION}.tar.gz && \
    tar xzvf openshift-client-linux-${OC_VERSION}.tar.gz && \
    sudo install oc /usr/local/bin/ && \
    rm kubectl  oc  openshift-client-linux-${OC_VERSION}.tar.gz

RUN kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null && \
    tanzu completion bash | sudo tee /etc/bash_completion.d/tanzu > /dev/null && \
    ytt completion bash | sudo tee /etc/bash_completion.d/ytt > /dev/null && \
    kapp completion bash | grep -v Succeeded | sudo tee /etc/bash_completion.d/kapp > /dev/null && \
    imgpkg completion bash | grep -v Succeeded | sudo tee /etc/bash_completion.d/imgpkg > /dev/null && \
    kctrl completion bash | grep -v Succeeded | sudo tee /etc/bash_completion.d/kctrl > /dev/null && \
    tilt completion bash | sudo tee /etc/bash_completion.d/tilt > /dev/null 

RUN rm -f LICENSE README.md

COPY conf/supervisor-editor.conf /opt/eduk8s/etc/supervisor/editor.conf
RUN rm /opt/eduk8s/.bash_profile
COPY conf/install-from-tanzunet.sh /home/eduk8s/install-from-tanzunet.sh

# workaround
RUN chown 1001:1001 -R /home/eduk8s
RUN chsh eduk8s -s /bin/bash
ENV PATH="/usr/local/bin:$PATH"

# cleanup
USER 1001
RUN mkdir -p ${VSCODE_USER} && echo "{\"java.home\":\"$(dirname /opt/jdk-*/bin/)\",\"maven.terminal.useJavaHome\":true, \"maven.executable.path\":\"/opt/apache-maven-${MAVEN_VERSION}/bin/mvn\",\"spring-boot.ls.java.home\":\"$(dirname /opt/jdk-*/bin/)\",\"files.exclude\":{\"**/.classpath\":true,\"**/.project\":true,\"**/.settings\":true,\"**/.factorypath\":true},\"redhat.telemetry.enabled\":false,\"java.server.launchMode\": \"Standard\"}" | jq . > ${VSCODE_USER}/settings.json
RUN rm -f /home/eduk8s/.wget-hsts
RUN fix-permissions /home/eduk8s
