FROM node:lts-alpine AS build-stage

RUN apk update && apk upgrade --no-cache

# Accept build arguments
ARG VITE_DEPLOYMENT_DATE
ARG VITE_BUILD_NUMBER
ARG VITE_VERCEL_GIT_COMMIT_SHA
ARG APP_VERSION

ENV NPM_CONFIG_LOGLEVEL warn
ENV CI true
WORKDIR /app

# Update package.json version if APP_VERSION is provided
COPY package.json pnpm-lock.yaml ./
RUN if [ -n "$APP_VERSION" ]; then \
      npm pkg set version="$APP_VERSION"; \
    fi

RUN npm install -g pnpm && pnpm i --frozen-lockfile
COPY . .

# Set environment variables for the build
ENV VITE_DEPLOYMENT_DATE=${VITE_DEPLOYMENT_DATE}
ENV VITE_BUILD_NUMBER=${VITE_BUILD_NUMBER}
ENV VITE_VERCEL_GIT_COMMIT_SHA=${VITE_VERCEL_GIT_COMMIT_SHA}

RUN pnpm build

FROM nginx:stable-alpine AS production-stage

RUN apk update && apk upgrade --no-cache

COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
