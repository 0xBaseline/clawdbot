# OpenClaw Railway Deployment

## Setup

1. **Create Railway project**
   - New Project → Deploy from GitHub or empty project
   - If empty: connect this `deploy/railway` directory

2. **Add a Volume**
   - Settings → Volumes → Add Volume
   - Mount path: `/data`
   - This persists config, sessions, and workspaces
   - The entrypoint only seeds config if it does not exist

3. **Set environment variables** (Settings → Variables)
   ```
   DISCORD_BOT_TOKEN=YOUR_DISCORD_BOT_TOKEN
    OPENCLAW_GATEWAY_TOKEN=...     (openssl rand -hex 32)
   ANTHROPIC_API_KEY=sk-ant-...   (from console.anthropic.com)
   ```
   Optional overrides:
   ```
   OPENCLAW_CONFIG_PATH=/data/.openclaw/openclaw.json
   OPENCLAW_STATE_DIR=/data/.openclaw
   OPENCLAW_WORKSPACE_DIR=/data/.openclaw/workspace
   ```

4. **Deploy**
   - Railway will build the Dockerfile and start the gateway

5. **Verify**
   - Check logs for "listening on ws://0.0.0.0:18789"
   - DM the Discord bot — it should respond

## Adding team members

Edit `openclaw.json`:

1. Add to `agents.list`:
   ```json
    { "id": "newuser", "workspace": "/data/.openclaw/workspace/newuser", "agentDir": "/data/.openclaw/agents/newuser/agent" }
   ```

2. Add to `bindings`:
   ```json
    { "agentId": "newuser", "match": { "channel": "discord", "peer": { "kind": "dm", "id": "DISCORD_USER_ID" } } }
   ```

3. Add to `channels.discord.dm.allowFrom`:
   ```json
    "allowFrom": ["DISCORD_USER_ID"]
   ```

4. Redeploy

## Current team

| Name     | Discord ID      |
|----------|-----------------|
| operator | DISCORD_USER_ID |
