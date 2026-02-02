FROM node:22-bookworm-slim

# Install git (required by OpenClaw dependencies)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install openclaw globally
RUN npm install -g openclaw@latest

# Copy config to a location outside the volume mount
COPY openclaw.json /default-config/openclaw.json
COPY auth-profiles.json /default-config/auth-profiles.json

# Copy and setup entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set environment
ENV OPENCLAW_CONFIG_PATH=/data/.openclaw/openclaw.json
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/.openclaw/workspace
ENV NODE_ENV=production

WORKDIR /data

EXPOSE 18789

ENTRYPOINT ["/entrypoint.sh"]
