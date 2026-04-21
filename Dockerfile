FROM --platform=$BUILDPLATFORM caddy:builder-alpine AS builder

ARG TARGETOS
ARG TARGETARCH

RUN GOOS=$TARGETOS GOARCH=$TARGETARCH xcaddy build \
    --with github.com/caddy-dns/rfc2136            \
    --with github.com/mholt/caddy-l4               \
    --with github.com/zhangjiayin/caddy-mysql-storage

FROM caddy:latest
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
