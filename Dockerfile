FROM new5tt/alpine-docker:latest

LABEL decription="ffmpeg docker"

ENV BASE_PACKAGE="ffmpeg"

RUN \
    apk update && apk upgrade && apk add ${BASE_PACKAGE} && \
    rm -rf /var/cache/apk/* &&\
    rm -rf /tmp/*