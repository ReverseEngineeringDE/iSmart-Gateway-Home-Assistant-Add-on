FROM eclipse-temurin:19-jre-jammy

WORKDIR /
RUN wget https://github.com/ReverseEngineeringDE/SAIC-API-Documentation/releases/download/latest/ismart-api-gateway-main-SNAPSHOT-full.jar
EXPOSE 42042
CMD ["java","-jar","/ismart-api-1.0-SNAPSHOT-full.jar"] 