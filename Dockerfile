# syntax=docker/dockerfile:1

# ---------- Etapa 1: dependencias (todas, para poder compilar) ----------
# Next.js 16 requiere Node >= 20.9, por eso se usa node:20-alpine (node:18 ya no es compatible).
FROM node:20-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

# ---------- Etapa 2: compilación (next build) ----------
FROM node:20-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build

# ---------- Etapa 3: solo dependencias de producción ----------
FROM node:20-alpine AS prod-deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# ---------- Etapa 4: imagen final (ligera, solo lo necesario para ejecutar) ----------
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production \
    NEXT_TELEMETRY_DISABLED=1 \
    PORT=3000

# Usuario sin privilegios (buena práctica de seguridad)
RUN addgroup -S nodejs -g 1001 && adduser -S nextjs -u 1001 -G nodejs

COPY --from=prod-deps --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --from=builder   --chown=nextjs:nodejs /app/.next ./.next
COPY --from=builder   --chown=nextjs:nodejs /app/public ./public
COPY --from=builder   --chown=nextjs:nodejs /app/package.json ./package.json
COPY --from=builder   --chown=nextjs:nodejs /app/next.config.ts ./next.config.ts

USER nextjs

# Puerto en el que escucha la aplicación
EXPOSE 3000

# Comando de inicio: next start (definido como "start" en package.json)
CMD ["npm", "start"]
