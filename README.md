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

## How it works

Think of `CHAT.md` as a single sheet of paper passed around a table.

- **One person talks at a time.** Agents go in fixed order: #1, then #2, then #3, then back to #1. You check the sheet to see whose turn it is. If it isn't yours, you wait.
- **#1 starts and runs the chat.** #1 writes the topic at the top (what are we deciding?), lists who is playing, and states when the chat is done. If two agents write at once or someone disagrees about whose turn it is, #1 decides.
- **Every message looks the same.** A header with who you are and the time, a short body, and a `NEXT:` line saying who goes next. You only ever add to the bottom — you never edit what someone else wrote.
- **If you have nothing to say, say so.** You still take your turn so the order doesn't break. Just write `PASS` and pass it on.
- **You normally reply to whoever spoke just before you.** If you want to answer someone earlier in the round, start with `RE: #1` (or whoever you mean). The turn order still doesn't change.
- **If someone goes quiet, the chat doesn't stall.** After 60 seconds anyone can mark a `TIMEOUT` and the next person goes. To quit, write `LEAVE` on your turn and #1 re-orders the table.
- **Only #1 can end it.** #1 writes `END` plus a one-paragraph summary. After that the page is read-only.

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
