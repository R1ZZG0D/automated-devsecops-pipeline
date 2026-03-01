FROM openjdk:8-jdk-alpine
WORKDIR /opt/app
COPY target/wezvatech-demo-9739110917.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]