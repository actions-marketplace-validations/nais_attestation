FROM alpine AS builder

ENV COSIGN_VERSION=v1.6.0
ENV SYFT_VERSION=v0.44.1
ENV GRYPE_VERSION=v0.35.0

RUN apk add curl docker
RUN curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin

RUN curl -sSfL https://raw.githubusercontent.com/anchore/grype/$GRYPE_VERSION/install.sh | sh -s -- -b /usr/local/bin

RUN curl -L -f https://github.com/sigstore/cosign/releases/download/$COSIGN_VERSION/cosign-linux-amd64 > /usr/local/bin/cosign && chmod +x /usr/local/bin/cosign

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
