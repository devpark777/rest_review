# 1단계: 빌드 스테이지
FROM gradle:8.5-jdk21 AS build
COPY --chown=gradle:gradle . /home/app
WORKDIR /home/app
RUN ./gradlew build -x test

# 2단계: 실행 스테이지 (에러가 발생한 부분을 아래 이미지로 대체합니다)
FROM eclipse-temurin:21-jre-jammy
EXPOSE 8080
COPY --from=build /home/app/build/libs/*-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
