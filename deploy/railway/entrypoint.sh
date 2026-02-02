#!/bin/bash
set -e

CONFIG_PATH=${OPENCLAW_CONFIG_PATH:-/data/.openclaw/openclaw.json}
STATE_DIR=${OPENCLAW_STATE_DIR:-/data/.openclaw}
WORKSPACE_DIR=${OPENCLAW_WORKSPACE_DIR:-/data/.openclaw/workspace}

echo "Syncing config to volume..."
mkdir -p "$(dirname "$CONFIG_PATH")" "$STATE_DIR" "$WORKSPACE_DIR/operator" "$STATE_DIR/agents/operator/agent"

if [ ! -f "$CONFIG_PATH" ]; then
  cp /default-config/openclaw.json "$CONFIG_PATH"
fi

if [ -n "${ANTHROPIC_OAUTH_TOKEN:-}" ]; then
  AUTH_PROFILES_PATH="$STATE_DIR/agents/operator/agent/auth-profiles.json"
  if [ ! -f "$AUTH_PROFILES_PATH" ]; then
    echo "Setting up auth profiles..."
    sed "s|\${ANTHROPIC_OAUTH_TOKEN}|${ANTHROPIC_OAUTH_TOKEN}|g" /default-config/auth-profiles.json > "$AUTH_PROFILES_PATH"
  fi
fi

exec openclaw gateway run --port 18789 --bind lan --verbose
