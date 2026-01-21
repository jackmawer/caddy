FROM caddy:2.10.2-builder AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/tailscale/caddy-tailscale \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http

FROM caddy:2.10.2-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

COPY base.Caddyfile /etc/caddy/Caddyfile
ENV CADDY_DOCKER_CADDYFILE_PATH /etc/caddy/Caddyfile

CMD ["caddy", "docker-proxy"]
