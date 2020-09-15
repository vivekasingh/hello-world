FROM adoptopenjdk/openjdk11:alpine AS builder

COPY . .

RUN ./gradlew --no-daemon build

FROM adoptopenjdk/openjdk11:alpine-jre

ENV APP_PATH /app

RUN mkdir ${APP_PATH}

WORKDIR ${APP_PATH}

VOLUME /tmp

COPY --from=builder build/libs/hello-world-*.jar /app/app.jar

CMD ["java", "${JAVA_OPTS:-}", "-jar", "app.jar"]
