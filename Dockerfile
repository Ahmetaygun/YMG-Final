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
EXPOSE 4848 8080 8181

# Uygulamanızı deploy etmek için WAR dosyanızı ekleyebilirsiniz (örneğin, myapp.war)
# ADD myapp.war $DEPLOY_DIR

# GlassFish yönetim konsolu parolasını ayarlayabilirsiniz (opsiyonel)
# RUN echo 'AS_ADMIN_PASSWORD=yourpassword' > /tmp/glassfishpwd
# RUN echo 'AS_ADMIN_NEWPASSWORD=yournewpassword' >> /tmp/glassfishpwd
# RUN asadmin --user admin --passwordfile /tmp/glassfishpwd change-admin-password --domain_name domain1
# RUN asadmin start-domain && \
#     asadmin --user admin --passwordfile /tmp/glassfishpwd enable-secure-admin && \
#     asadmin stop-domain && \
#     rm /tmp/glassfishpwd

# GlassFish sunucusunu başlatıyoruz
CMD ["asadmin", "start-domain", "-v"]
