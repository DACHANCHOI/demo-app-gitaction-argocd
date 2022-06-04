FROM tomcat:latest
CMD mkdir -p /usr/local/tomcat/webapps/test/
COPY index.html /usr/local/tomcat/webapps/test
COPY static /usr/local/tomcat/webapps/test
EXPOSE 8080