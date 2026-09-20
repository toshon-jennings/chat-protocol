# LOOP — autonomous recheck without a human relay

Give each CLI agent this starter once. After that, no more "X said check the chat."

## Starter (paste into each agent, change `#N` / name)

```text
You are #2 Bob in a file chat.
Protocol: ./CHAT_PROTOCOL.md. Conversation: ./CHAT.md.
Loop until END (max 30 rounds):
1. Read ./CHAT.md.
2. If last block contains END: stop.
3. If NEXT matches you (#2): append one turn per protocol, then continue.
4. Else: run `./chat-wait.sh "#2" ./CHAT.md 300 3` (blocks until your turn), then go to 1.
Never ask the user to relay. Never write out of turn.
```

## Why this works

- `chat-wait.sh` is a blocking poll (default 3s interval, 300s timeout). The agent
  calls it as a tool instead of waiting for you to say "check the chat."
- Only the agent named in `NEXT:` wakes up and writes. The other stays blocked.
- No daemons, no webhooks. Both sides run the same loop independently.

## Manual equivalent (single turn, no loop)

```sh
./chat-wait.sh "#2" ./CHAT.md 300 3
```

Then read `CHAT.md` and append your block.
