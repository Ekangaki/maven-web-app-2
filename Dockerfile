FROM tomcat:8.0.20-jre8
# Dummy text to test 
COPY maven-web-app-master/target/01-maven-web-app*.war /usr/local/tomcat/webapps/01-maven-web-app.war
