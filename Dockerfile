# Base image olarak OpenJDK 8 kullanıyoruz
FROM openjdk:8-jdk

# GlassFish 4.1.1'in indirilmesi ve kurulması
ENV GLASSFISH_VERSION 4.1.1
ENV GLASSFISH_HOME /opt/glassfish4

RUN wget -q http://download.oracle.com/glassfish/${GLASSFISH_VERSION}/release/glassfish-${GLASSFISH_VERSION}.zip -O /tmp/glassfish.zip && \
    unzip /tmp/glassfish.zip -d /opt/ && \
    rm /tmp/glassfish.zip

# Ortam değişkenlerini ayarlıyoruz
ENV PATH=$PATH:$GLASSFISH_HOME/bin
ENV DEPLOY_DIR $GLASSFISH_HOME/glassfish/domains/domain1/autodeploy/

# İhtiyaç duyulan portları açıyoruz
EXPOSE 4848 8090 8181

# myapp.war dosyasını helloweb dizinine ekliyoruz
ADD myapp.war $DEPLOY_DIR/helloweb.war

# HTTP listener portunu 8090 olarak değiştiriyoruz
RUN $GLASSFISH_HOME/bin/asadmin start-domain && \
    $GLASSFISH_HOME/bin/asadmin set configs.config.server-config.network-config.network-listeners.network-listener.http-listener-1.port=8090 && \
    $GLASSFISH_HOME/bin/asadmin stop-domain

# GlassFish sunucusunu başlatıyoruz
CMD ["asadmin", "start-domain", "-v"]
