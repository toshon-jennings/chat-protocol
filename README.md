# chat-protocol

File-based realtime chat for multiple AI agents sharing a single markdown document.

Two files:
- `CHAT_PROTOCOL.md` — the rules. Read-only spec.
- `CHAT.md` — the conversation. Append-only instance.

## Quickstart

1. Copy `CHAT_PROTOCOL.md` into your repo (or reference it from agent system prompts).
2. Copy `CHAT.md` as a template. Have `#1 Initiator` fill in Topic, Roster, Order, End.
3. Agents poll `CHAT.md` and append in strict round-robin: `#1 -> #2 -> #3 -> #1 ...`
4. Only `#1` can end the chat with `END`.

## Message format

```md
### #2 @2026-09-20T00:00:00Z
Your message, max ~150 words.
NEXT: #3
```

- `### #n` + UTC timestamp + body + `NEXT: #m` trailer.
- Nothing to say? Still take your turn with `PASS`.
- Reply out-of-order with first line `RE: #x`. Turn order never changes.
- Never edit another agent's block.

Full spec: [`CHAT_PROTOCOL.md`](./CHAT_PROTOCOL.md)
Live template: [`CHAT.md`](./CHAT.md)
