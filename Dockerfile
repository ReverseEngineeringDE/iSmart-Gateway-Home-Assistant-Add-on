# AMD/Intel based Linux
# FROM amd64/eclipse-temurin
# AMD/Intel based Windows
# FROM winamd64/eclipse-temurin
# ARM32
# FROM arm32v7/eclipse-temurin

# Use for Raspberry Pi
FROM arm64v8/eclipse-temurin

WORKDIR /
ADD ismart-api-1.0-SNAPSHOT-full.jar ismart-api-1.0-SNAPSHOT-full.jar
EXPOSE 42042
CMD ["java","-jar","/ismart-api-1.0-SNAPSHOT-full.jar"] 