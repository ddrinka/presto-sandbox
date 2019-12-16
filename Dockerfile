FROM openjdk:8-jre

ENV PRESTO_VERSION 326

RUN apt-get update && \
  apt-get install -yf python less && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  mkdir /opt/presto && \
  curl https://repo1.maven.org/maven2/io/prestosql/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz -o presto-server.tar.gz && \ 
  tar xfz presto-server.tar.gz -C /opt/presto --strip-components=1 && \
  rm presto-server.tar.gz

ADD https://repo1.maven.org/maven2/io/prestosql/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar /usr/local/bin/presto-cli

RUN chmod a+x /usr/local/bin/presto-cli

COPY etc /opt/presto/etc

EXPOSE 8080
ENTRYPOINT ["/opt/presto/bin/launcher", "run"]

