FROM ubuntu:latest
ARG CONFLUENCE_VERSION=6.10
ADD https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-${CONFLUENCE_VERSION}-x64.bin .
ADD response.varfile .
EXPOSE 8090
RUN chmod 755 atlassian-confluence-${CONFLUENCE_VERSION}-x64.bin
RUN ./atlassian-confluence-${CONFLUENCE_VERSION}-x64.bin -q -varfile response.varfile
RUN rm atlassian-confluence-${CONFLUENCE_VERSION}-x64.bin
# DB: atlassian-postgres.atlassian.svc.cluster.local
ENTRYPOINT /opt/atlassian/confluence/jre//bin/java -Djava.util.logging.config.file=/opt/atlassian/confluence/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djdk.tls.ephemeralDHKeySize=2048 -Djava.protocol.handler.pkgs=org.apache.catalina.webresources -Dorg.apache.catalina.security.SecurityListener.UMASK=0027 -XX:ReservedCodeCacheSize=256m -XX:+UseCodeCacheFlushing -Dconfluence.context.path= -Datlassian.plugins.startup.options= -Dorg.apache.tomcat.websocket.DEFAULT_BUFFER_SIZE=32768 -Dsynchrony.enable.xhr.fallback=true -Xms1024m -Xmx1024m -XX:+UseG1GC -Datlassian.plugins.enable.wait=300 -Djava.awt.headless=true -XX:G1ReservePercent=20 -Xloggc:/opt/atlassian/confluence/logs/gc-2018-07-02_16-06-36.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=2M -XX:-PrintGCDetails -XX:+PrintGCDateStamps -XX:-PrintTenuringDistribution -Dignore.endorsed.dirs= -classpath /opt/atlassian/confluence/bin/bootstrap.jar:/opt/atlassian/confluence/bin/tomcat-juli.jar -Dcatalina.base=/opt/atlassian/confluence -Dcatalina.home=/opt/atlassian/confluence -Djava.io.tmpdir=/opt/atlassian/confluence/temp org.apache.catalina.startup.Bootstrap start
