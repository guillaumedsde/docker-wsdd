FROM alpine:latest as build

ARG VERSION=master

WORKDIR /

RUN wget "https://github.com/christgau/wsdd/blob/${VERSION}/src/wsdd.py" -O /wsdd \
    && chmod 755 /wsdd

FROM gcr.io/distroless/python3

COPY --from=build /wsdd /usr/bin/wsdd

ENTRYPOINT [ "python", "/usr/bin/wsdd" ] 