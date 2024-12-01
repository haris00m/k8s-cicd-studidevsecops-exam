# Stage 1: Base
FROM oven/bun:1.1.3-alpine AS base
WORKDIR /usr/src/app

# Stage 2: Install Dependencies
FROM base AS install
RUN mkdir -p /temp/dev
COPY package.json bun.lockb /temp/dev/
RUN cd /temp/dev && bun install --frozen-lockfile

# Install production dependencies
RUN mkdir -p /temp/prod
COPY package.json bun.lockb /temp/prod/
RUN cd /temp/prod && bun install --frozen-lockfile --production

# Stage 3: Build Application
FROM base AS build
COPY --from=install /temp/dev/node_modules node_modules
COPY . .
ENV NODE_ENV=production
RUN bun run build

# Stage 4: Serve with Nginx
FROM nginx:alpine3.20
WORKDIR /usr/share/nginx/html

# Remove default Nginx static files
RUN rm -rf ./*

# Copy build files from the build stage
COPY --from=build /usr/src/app/dist .

# Expose port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]