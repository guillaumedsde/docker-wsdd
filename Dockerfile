FROM alpine:latest as build

WORKDIR /

RUN wget "https://raw.githubusercontent.com/christgau/wsdd/master/src/wsdd.py" -O /wsdd \
    && chmod 755 /wsdd

FROM gcr.io/distroless/python3

COPY --from=build /wsdd /usr/bin/wsdd

ENTRYPOINT [ "python", "/usr/bin/wsdd" ] 