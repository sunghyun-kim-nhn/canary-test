# Base image
FROM maven:3.8.3-openjdk-17 AS builder

# Working directory 설정
COPY . /canary-test
WORKDIR /canary-test

# 애플리케이션 빌드
RUN mvn package -DskipTests

# 실제 애플리케이션을 실행할 이미지 생성
FROM openjdk:17-alpine

# 빌드된 JAR 파일을 복사
COPY --from=builder /canary-test/target/*.jar /canary-test/canary-test.jar

# 애플리케이션 실행
CMD ["java", "-jar", "/canary-test/canary-test.jar"]
