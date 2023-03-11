#FROM eclipse-temurin
#ARG TARGETPLATFORM
ARG BUILD_FROM
FROM $BUILD_FROM
RUN apk add --update-cache \
    openjdk11 \
  && rm -rf /var/cache/apk/*

WORKDIR /
ADD https://github.com/ReverseEngineeringDE/SAIC-API-Documentation/releases/download/latest/ismart-mqtt-gateway-latest-full.jar /ismart-mqtt-gateway-latest-full.jar
COPY startup.sh /
RUN chmod a+x /startup.sh
CMD ["/startup.sh"] 
