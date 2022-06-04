FROM tomcat:latest
# CMD mkdir -p /usr/local/tomcat/webapps/test/
COPY index.html /usr/local/tomcat/webapps/test/
COPY static /usr/local/apache2/htdocs/static
EXPOSE 8080