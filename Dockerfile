FROM centos
FROM openjdk

# Gradle Configuration
FROM gradle:4.7.0-jdk8-alpine AS build
WORKDIR /home/app/

COPY --chown=gradle:gradle function /home/app/

# Run local build
RUN gradle build --no-daemon

# install Spring Boot artifact
VOLUME /tmp
EXPOSE 8082

#FROM centos
#FROM openjdk
COPY --from=build /home/app/project/build/libs/project-0.0.1-SNAPSHOT.jar project-0.0.1.jar
#ADD build/libs/project-0.0.1-SNAPSHOT.jar project-0.0.1.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","project-0.0.1.jar"]
CMD ["java", "-jar", "project-0.0.1.jar"]
