FROM openjdk:8-jdk-alpine

MAINTAINER Tien Tran

ARG download_url
ENV TZ=Australia/Melbourne \
    DOWNLOAD_URL=$download_url

COPY 8/rootfs /

RUN apk update && apk upgrade && apk --no-cache add bash curl tzdata dpkg && \
    addgroup pentaho && \
    adduser  -G pentaho -s /bin/sh -D pentaho && \
    echo "pentaho:$(date | md5sum | head -c 32)" | /usr/sbin/chpasswd && \
    # install gosu
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" && \
    curl -fsSL "https://github.com/tianon/gosu/releases/download/1.11/gosu-$dpkgArch" -o /usr/local/bin/gosu && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true && \
    # complete gosu
    # check pre-downloaded package for local builds
    curl -fSL ${DOWNLOAD_URL:-https://nchc.dl.sourceforge.net/project/pentaho/Pentaho%208.2/client-tools/pdi-ce-8.2.0.0-342.zip} -o /home/pentaho/pdi-ce.zip; \
    cd /home/pentaho && \
    unzip pdi-ce.zip && \
    rm -rf /home/pentaho/pdi-ce.zip && \
    curl -fsSL http://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.47/mysql-connector-java-5.1.47.jar -o /home/pentaho/data-integration/lib/mysql-connector-java-5.1.47.jar && \
    chown -R pentaho:pentaho /home/pentaho/data-integration && \
    chmod u+x /entrypoint.sh && \
    apk del curl dpkg && \
    rm -rf /apk /tmp/* /var/cache/apk/*

WORKDIR /home/pentaho

ENTRYPOINT ["/entrypoint.sh"]
#CMD ["su", "-m", "-c", "/home/pentaho/data-integration/kitchen.sh", "pentaho"]
