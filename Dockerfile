# Stage 1 of 2
FROM golang:stretch
RUN go get -u github.com/arduino/arduino-cli


# Stage 2 of 2
FROM debian:stretch
COPY --from=0 /go/bin/arduino-cli /usr/bin/arduino-cli
ADD cli-config.yml /root/.arduino15/arduino-cli.yaml
ENV HOME /root
WORKDIR /root
RUN apt-get update && \
    apt-get install -yy -q --no-install-recommends \
      make ca-certificates python3 && \
    apt-get auto-remove && \
    rm -rf /var/lib/apt/lists/* && \
    arduino-cli -v lib install PubSubClient Unified\ Log && \
    arduino-cli -v core update-index && \
    arduino-cli core install esp8266:esp8266 -v
WORKDIR /build

ENTRYPOINT ["/usr/bin/arduino-cli"]
