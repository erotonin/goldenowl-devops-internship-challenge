FROM node:24.14.1-trixie-slim@sha256:9707cd4542f400df5078df04f9652a272429112f15202d22b5b8bdd148df494f AS dependencies
WORKDIR /app
COPY package.json package-lock.json ./

RUN npm ci \
    --omit=dev \
    --ignore-scripts \
    --no-audit \
    --no-fund

FROM gcr.io/distroless/nodejs24-debian13:nonroot@sha256:af85d11ce7ef10172855a6e3649e3e8125b1b9e3ca41849ec2918036f05cb212 AS runtime
ENV NODE_ENV=production
ENV PORT=3000
WORKDIR /app

COPY --from=dependencies --chown=65532:65532 /app/node_modules ./node_modules
COPY --chown=65532:65532 index.js ./
COPY --chown=65532:65532 routes ./routes
COPY --chown=65532:65532 server ./server

USER 65532:65532
EXPOSE 3000
STOPSIGNAL SIGTERM

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD ["/nodejs/bin/node", "-e", "fetch('http://127.0.0.1:3000/').then((response) => process.exit(response.ok ? 0 : 1)).catch(() => process.exit(1))"]

CMD ["index.js"]
