FROM alpine:latest

RUN apk upgrade --no-cache \
  && apk add --no-cache ca-certificates s3cmd mongodb-tools

WORKDIR /s3

ENTRYPOINT ["s3cmd"]
CMD ["--help"]