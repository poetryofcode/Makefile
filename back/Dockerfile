# syntax=docker/dockerfile:1.7

# ---- Stage 1: builder ----
# TODO:
#   - Set the working directory
#   - Install all dependencies (including dev deps needed to compile)
#   - Copy TypeScript config files (tsconfig*.json, nest-cli.json) and the src/ folder
#   - Run the production build (compile TS into dist/)
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
# tsconfig*.json, nest-cli.json i thought to move them before package.json because they rearly changes but turn out when they change then need to run all packages but it is costly
COPY tsconfig*.json ./
COPY nest-cli.json ./
COPY src ./src 
# we can not copy name of the folder (first argument) it only copies what inside of that folder therefore we need give the same name as second argument
RUN npm run build

# ---- Stage 2: runtime ----
# TODO:
#   - Set the working directory
#   - Set NODE_ENV=production
#   - Install only production dependencies
#   - Copy the compiled dist/ from the builder stage
#   - EXPOSE the app port and start the server (node dist/main.js)
FROM node:20-alpine AS runtime
WORKDIR /app
ENV NODE_ENV=production
COPY package*.json ./
RUN npm ci --omit=dev
# --omit dev -> we do not development dependencies only prod
COPY --from=builder /app/dist ./dist
EXPOSE 3000
CMD [ "node", "dist/main.js"] 