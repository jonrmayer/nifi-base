FROM       alpine
MAINTAINER Viacheslav Kalashnikov <xemuliam@gmail.com>
ARG        DIST_MIRROR=http://archive.apache.org/dist/nifi
ARG        VERSION=1.3.0
ENV        NIFI_HOME=/opt/nifi \
           JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk \
           PATH=$PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
RUN        apk update && apk add --upgrade bash curl openjdk8 && \
           mkdir -p ${NIFI_HOME} && \
           curl ${DIST_MIRROR}/${VERSION}/nifi-${VERSION}-bin.tar.gz | tar xvz -C ${NIFI_HOME} && \
           mv ${NIFI_HOME}/nifi-${VERSION}/* ${NIFI_HOME} && \
           rm -rf ${NIFI_HOME}/nifi-${VERSION} && \
           rm -rf *.tar.gz && \
           rm -rf /var/cache/apk/*
EXPOSE     8080 8081 8443
VOLUME     ${NIFI_HOME}/logs \
           ${NIFI_HOME}/flowfile_repository \
           ${NIFI_HOME}/database_repository \
           ${NIFI_HOME}/content_repository \
           ${NIFI_HOME}/provenance_repository
WORKDIR    ${NIFI_HOME}
ENV qqq ppp
CMD        ./bin/nifi.sh run
