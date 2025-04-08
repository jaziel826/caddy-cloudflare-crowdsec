# the different stages of this Dockerfile are meant to be built into separate images
# https://docs.docker.com/develop/develop-images/multistage-build/#stop-at-a-specific-build-stage
# https://docs.docker.com/compose/compose-file/#target


# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG CADDY_VERSION=2.9.1

FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-l4 \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@main \
    --with github.com/hslatman/caddy-crowdsec-bouncer/layer4@main \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/caddyserver/certmagic@master \
  #  --with github.com/caddyserver/caddy@master \
   # --with github.com/caddyserver/certmagic@b9399eadfbe7ac3092f4e65d45284b3aabe514f8 \
   # --with github.com/caddyserver/caddy@9becf61a9f5bafb88a15823ce80c1325d3a30a4f
    
FROM caddy:${CADDY_VERSION}

WORKDIR /

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

