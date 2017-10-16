FROM       alpine
MAINTAINER Viacheslav Kalashnikov <xemuliam@gmail.com>
ARG        DIST_MIRROR=http://archive.apache.org/dist/nifi
ARG        VERSION=1.3.0
ENV        NIFI_HOME=/opt/nifi \
           JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk \
           PATH=$PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
RUN        apk add --no-cache bash curl openjdk8 && \
           mkdir -p ${NIFI_HOME} && \
           curl ${DIST_MIRROR}/${VERSION}/nifi-${VERSION}-bin.tar.gz | tar xvz -C ${NIFI_HOME} && \
           mv ${NIFI_HOME}/nifi-${VERSION}/* ${NIFI_HOME} && \
           rm -rf ${NIFI_HOME}/nifi-${VERSION} && \
           rm -rf *.tar.gz && \
           cd ${NIFI_HOME}/lib && \
           find . \
               ! -path './bootstrap*' \
               ! -name 'javax.servlet-api*.jar' \
               ! -name 'jcl-over-slf4j*.jar' \
               ! -name 'jetty-schemas*.jar' \
               ! -name 'jul-to-slf4j*.jar' \
               ! -name 'log4j-over-slf4j*.jar' \
               ! -name 'logback-classic*.jar' \
               ! -name 'logback-core*.jar' \
               ! -name 'nifi-api*.jar' \
               ! -name 'nifi-dbcp-service-nar*.nar' \
               ! -name 'nifi-distributed-cache-services-nar*.nar' \
               ! -name 'nifi-documentation*.jar' \
               ! -name 'nifi-framework-api*.jar' \
               ! -name 'nifi-framework-nar*.nar' \
               ! -name 'nifi-html-nar*.nar' \
               ! -name 'nifi-http-context-map-nar*.nar' \
               ! -name 'nifi-jetty-bundle*.nar' \
               ! -name 'nifi-kerberos-iaa-providers-nar*.nar' \
               ! -name 'nifi-ldap-iaa-providers-nar*.nar' \
               ! -name 'nifi-lookup-services-nar*.nar' \
               ! -name 'nifi-nar-utils*.jar' \
               ! -name 'nifi-properties*.jar' \
               ! -name 'nifi-provenance-repository-nar*.nar' \
               ! -name 'nifi-runtime*.jar' \
               ! -name 'nifi-scripting-nar*.nar' \
               ! -name 'nifi-site-to-site-reporting-nar*.nar' \
               ! -name 'nifi-ssl-context-service-nar*.nar' \
               ! -name 'nifi-standard-nar*.nar' \
               ! -name 'nifi-standard-services-api-nar*.nar' \
               ! -name 'nifi-update-attribute-nar*.nar' \
               ! -name 'nifi-websocket-services-api-nar*.nar' \
               ! -name 'nifi-websocket-services-jetty-nar*.nar' \
               ! -name 'slf4j-api*.jar' \
               -delete
EXPOSE     8080 8081 8443
VOLUME     ${NIFI_HOME}/logs \
           ${NIFI_HOME}/flowfile_repository \
           ${NIFI_HOME}/database_repository \
           ${NIFI_HOME}/content_repository \
           ${NIFI_HOME}/provenance_repository
WORKDIR    ${NIFI_HOME}
CMD        ./bin/nifi.sh run