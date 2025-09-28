FROM caddy:2.10.2-builder AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/tailscale/caddy-tailscale=github.com/evan314159/caddy-tailscale@fix-dynamic-config

FROM caddy:2.10.2-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy


CMD ["caddy", "docker-proxy"]
