FROM tomcat:latest
# Dummy text to test 
COPY target/01-maven-web-app*.war /usr/local/tomcat/webapps/01-maven-web-app.war
