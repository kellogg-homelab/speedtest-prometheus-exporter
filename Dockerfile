FROM alpine:latest

ARG LIBRESPEED_ARCH="amd64"
ARG LIBRESPEED_VER="1.0.14"
ARG LIBRESPEED_URL="https://github.com/librespeed/speedtest-cli/releases/download/v${LIBRESPEED_VER}/librespeed-cli_${LIBRESPEED_VER}_linux_${LIBRESPEED_ARCH}.tar.gz"
ARG LIBRESPEED_TAR="/tmp/librespeed-cli.tar.gz"

ARG SCRIPT_EXPORTER_ARCH="amd64"
ARG SCRIPT_EXPORTER_VER="3.3.0"
ARG SCRIPT_EXPORTER_URL="https://github.com/ricoberger/script_exporter/releases/download/v${SCRIPT_EXPORTER_VER}/script_exporter-linux-${SCRIPT_EXPORTER_ARCH}.tar.gz"
ARG SCRIPT_EXPORTER_TAR="/tmp/script-exporter.tar.gz"

# Install librespeed-cli
RUN wget -O ${LIBRESPEED_TAR} ${LIBRESPEED_URL}                 && \
    tar -C /usr/local/bin/ -xf ${LIBRESPEED_TAR} librespeed-cli && \
    rm -f ${LIBRESPEED_TAR}

RUN wget -O ${SCRIPT_EXPORTER_TAR} ${SCRIPT_EXPORTER_URL}             && \
    tar -C /usr/local/bin/ -xf ${SCRIPT_EXPORTER_TAR} script_exporter && \
    rm -f ${SCRIPT_EXPORTER_TAR}

COPY speedtest-exporter.sh        /usr/local/bin/speedtest-exporter.sh
COPY script-exporter-config.yaml  /usr/local/share/script-exporter-config.yaml

EXPOSE 9469

ENTRYPOINT  [ "/usr/local/bin/script_exporter", "--config.files=/usr/local/share/script-exporter-config.yaml"]
