FROM gradle:4.7.0-jdk8-alpine AS build
COPY --chown=gradle:gradle function /home/gradle/src/
WORKDIR /home/gradle/src

# Run local build
RUN gradle build --no-daemon

# install Spring Boot artifact
VOLUME /tmp
EXPOSE 8080

FROM centos
FROM openjdk
COPY --from=build /home/gradle/src/build/libs/HelloWorld-0.0.1-SNAPSHOT.jar HelloWorld-0.0.1.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","HelloWorld-0.0.1.jar"]
CMD ["java", "-jar", "HelloWorld-0.0.1.jar"]
