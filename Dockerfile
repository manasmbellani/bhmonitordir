FROM alpine:latest
LABEL maintainer="manasmbellani"

RUN apk add --update \
    bash \
    grep

COPY . /app
WORKDIR /app

ENTRYPOINT [ "/bin/bash", "bhmonitordir.sh" ]
