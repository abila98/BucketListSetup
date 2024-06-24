FROM adoptopenjdk:11-jdk-hotspot as builder
RUN apt-get update && \
    apt-get install -y ant

WORKDIR /work

COPY application /work/

RUN ant war

# Stage 2: Run Tomcat and deploy the WAR file
FROM tomcat:9.0.56-jdk11-corretto

# Set the working directory
WORKDIR /usr/local/tomcat/webapps/


#COPY cert/portfolio.crt /usr/local/tomcat/conf/portfolio.crt
#COPY cert/portfolio.key /usr/local/tomcat/conf/portfolio.key
#COPY server.xml /usr/local/tomcat/conf/ 
# Copy the WAR file from the previous stage
COPY --from=builder /work/war/bucketlist.war . 

# Expose port 8080
EXPOSE 8080
#EXPOSE 8443
# Start Tomcat
CMD ["catalina.sh", "run"]
