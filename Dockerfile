FROM coolersport/alpine-java:8u172b11_jdk_unlimited

MAINTAINER Tien Tran

RUN apk --no-cache --update add curl && \
    curl -fsSL https://nchc.dl.sourceforge.net/project/pentaho/Pentaho%208.0/client-tools/pdi-ce-8.0.0.0-28.zip -o /home/alpine/pdi-ce.zip && \
    cd /home/alpine && \
    unzip pdi-ce.zip && \
    rm -rf /home/alpine/pdi-ce.zip && \
    chown -R alpine:alpine /home/alpine/data-integration && \
    rm -rf /apk /tmp/* /var/cache/apk/*

CMD ["/bin/bash"]
#CMD ["su", "-m", "-c", "/home/alpine/data-integration/kitchen.sh", "alpine"]
