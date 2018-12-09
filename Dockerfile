# Stage 1 of 2
FROM golang:stretch
RUN go get -u github.com/arduino/arduino-cli


# Stage 2 of 2
FROM debian:stretch
COPY --from=0 /go/bin/arduino-cli /usr/bin/arduino-cli
ADD cli-config.yml /etc/cli-config.yml
RUN apt-get update && \
    apt-get install -yy -q --no-install-recommends \
      make ca-certificates && \
    apt-get auto-remove && \
    rm -rf /var/lib/apt/lists/* && \
    arduino-cli lib install PubSubClient Unified\ Log && \
    arduino-cli core update-index --config-file /etc/cli-config.yml && \
    arduino-cli core install esp8266:esp8266 --config-file /etc/cli-config.yml
WORKDIR /build

ENTRYPOINT ["/usr/bin/arduino-cli"]
