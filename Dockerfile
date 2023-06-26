FROM alpine
RUN apk --no-cache add s3fs-fuse

COPY .passwd-s3fs main.sh /root/

ENTRYPOINT [ "sh", "/root/main.sh" ]
