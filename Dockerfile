FROM alpine:latest as build

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="wsdd" \
    org.label-schema.description=" Web Service Discovery host daemon (wsdd) in a docker container " \
    org.label-schema.url="https://guillaumedsde.gitlab.io/docker-wsdd/" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-url="https://github.com/guillaumedsde/docker-wsdd" \
    org.label-schema.vendor="guillaumedsde" \
    org.label-schema.schema-version="1.0"

ARG VERSION=master

WORKDIR /

RUN wget "https://github.com/christgau/wsdd/blob/${VERSION}/src/wsdd.py" -O /wsdd \
    && chmod 755 /wsdd

FROM gcr.io/distroless/python3

COPY --from=build /wsdd /usr/bin/wsdd

ENTRYPOINT [ "python", "/usr/bin/wsdd" ] 