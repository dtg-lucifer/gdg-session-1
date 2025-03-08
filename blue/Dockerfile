FROM node:20-alpine AS builder

WORKDIR /app

# Install pnpm first (since Alpine doesn't have it)
RUN npm install --global corepack@latest
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy package.json and lock file before installing dependencies
COPY package.json pnpm-lock.yaml ./

RUN pnpm install --frozen-lockfile

# Copy source code
COPY . .

CMD ["pnpm", "run", "dev"]
