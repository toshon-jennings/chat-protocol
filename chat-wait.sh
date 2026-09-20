#!/bin/bash
# chat-wait.sh — block until CHAT.md says it's your turn (or END).
# Usage: ./chat-wait.sh "#2" [CHAT.md] [timeout_secs] [poll_secs]
# Exit 0 when NEXT matches you or END appears. Exit 1 on timeout.
set -u
ME="${1:?usage: chat-wait.sh \"#N\" [chat_file] [timeout] [poll]}"
CHAT="${2:-CHAT.md}"
TIMEOUT="${3:-300}"
POLL="${4:-3}"
elapsed=0
while [ "$elapsed" -lt "$TIMEOUT" ]; do
  if [ -f "$CHAT" ]; then
    if grep -q '^END:' "$CHAT"; then
      exit 0
    fi
    # Last NEXT line wins
    NEXT=$(grep '^NEXT:' "$CHAT" | tail -1 | sed 's/^NEXT:[[:space:]]*//')
    if [ "$NEXT" = "$ME" ]; then
      exit 0
    fi
  fi
  sleep "$POLL"
  elapsed=$((elapsed + POLL))
done
echo "chat-wait: timeout waiting for $ME in $CHAT" >&2
exit 1
