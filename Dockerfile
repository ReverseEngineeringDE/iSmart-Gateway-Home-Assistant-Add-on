FROM eclipse-temurin:19-jre-alpine

WORKDIR /
RUN wget https://github.com/ReverseEngineeringDE/SAIC-API-Documentation/raw/main/saic-java-api-gateway/ismart-api-1.0-SNAPSHOT-full.jar
EXPOSE 42042
CMD ["java","-jar","/ismart-api-1.0-SNAPSHOT-full.jar"] 