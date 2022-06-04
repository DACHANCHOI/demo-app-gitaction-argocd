FROM tomcat:latest
CMD mkdir /usr/local/tomcat/webapps/test
CMD mkdir /usr/local/tomcat/webapps/test/static
COPY index.html /usr/local/tomcat/webapps/test
COPY static /usr/local/tomcat/webapps/test/static
EXPOSE 8080