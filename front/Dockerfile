# syntax=docker/dockerfile:1.7

# ---- Stage 1: builder ----
# TODO:
#   - Set the working directory
#   - Declare a build argument VITE_API_URL and expose it as an env var
#     (Vite bakes env vars into the bundle at build time)
#   - Install all dependencies
#   - Copy the source code
#   - Run the production build (static files go to dist/)
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./ 
# forgot to copy package.json
RUN npm ci
# first we need to declare arg; but arg itself can not be passed as variable therefore we need pass arg as env
ARG VITE_API_URL
ENV VITE_API_URL=${VITE_API_URL}
COPY . .
RUN npm run build

# ---- Stage 2: nginx runtime ----
# TODO:
#   - Copy the built static files from the builder stage to nginx's html dir
#   - Copy the custom nginx.conf into /etc/nginx/conf.d/
#   - EXPOSE port 80 and run nginx in the foreground
FROM nginx:alpine AS runtime
# COPY --from=builder /app/next/standalone ./ it is for next
# static files creates in dist folder
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
# main thing if something working inside container then container is working, once main process (PID1) stopped then container is stop and our app is stopped. So we use daemon 0ff - to make in forground (it means always keep running). By default nginx server runs in background and it is a problem because Docker thinks nginx stopped and therefore Docker stops that container running.
