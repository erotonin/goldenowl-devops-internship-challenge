FROM node:24.14.1-bookworm-slim AS dependencies
WORKDIR /app
COPY package.json package-lock.json ./

RUN npm ci \
    --omit=dev \
    --ignore-scripts \
    --no-audit \
    --no-fund

FROM node:24.14.1-bookworm-slim AS runtime
ENV NODE_ENV=production
ENV PORT=3000
WORKDIR /app

COPY --from=dependencies /app/node_modules ./node_modules
COPY package.json index.js ./
COPY routes ./routes
COPY server ./server

USER node
EXPOSE 3000
STOPSIGNAL SIGTERM

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD ["node", "-e", "fetch('http://127.0.0.1:3000/').then((response) => process.exit(response.ok ? 0 : 1)).catch(() => process.exit(1))"]

CMD ["node", "index.js"]