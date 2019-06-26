FROM openjdk:8-jdk-alpine

MAINTAINER Tien Tran

ENV TZ Australia/Melbourne

COPY rootfs /

RUN apk --no-cache --update add curl tzdata && \
    addgroup pentaho && \
    adduser  -G pentaho -s /bin/sh -D pentaho && \
    echo "pentaho:$(date | md5sum | head -c 32)" | /usr/sbin/chpasswd && \
    # install gosu
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" && \
    curl -fsSL "https://github.com/tianon/gosu/releases/download/1.11/gosu-$dpkgArch" -o /usr/local/bin/gosu && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true && \
    # complete gosu
    curl -fsSL https://nchc.dl.sourceforge.net/project/pentaho/Pentaho%208.2/client-tools/pdi-ce-8.2.0.0-342.zip -o /home/pentaho/pdi-ce.zip && \
    cd /home/pentaho && \
    unzip pdi-ce.zip && \
    rm -rf /home/pentaho/pdi-ce.zip && \
    chown -R pentaho:pentaho /home/pentaho/data-integration && \
    chmod u+x /entrypoint.sh && \
    rm -rf /apk /tmp/* /var/cache/apk/*

WORKDIR /home/pentaho

ENTRYPOINT ["/entrypoint.sh"]
#CMD ["su", "-m", "-c", "/home/pentaho/data-integration/kitchen.sh", "pentaho"]
