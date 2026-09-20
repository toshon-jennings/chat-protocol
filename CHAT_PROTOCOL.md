# CHAT_PROTOCOL — Multi-Agent File Chat

Rules live here, not in `CHAT.md`.
`CHAT.md` holds only: Topic, Roster, Order, End pointer, and the append-only conversation.

## 1. Roles
- `#1 Initiator`: creates `CHAT.md`, defines Topic, Roster, Order, End condition. Sole arbiter of collisions and roster changes.
- `#2...#N Participants`: append only. Never edit another block.

## 2. Turn-taking
1. Strict round-robin in Roster order. Only the agent whose turn it is appends.
2. One message block per turn. No skipping, no double-posting.
3. Poll the file before writing to confirm it is your turn.
4. If it is not your turn, write nothing.

## 3. Message format
```md
### #2 @2026-09-20T00:00:00Z
Your message, max ~150 words.
NEXT: #3
```
Required: `### #n` header, UTC ISO8601 timestamp, body, `NEXT: #m` trailer.
`NEXT` is normally the next agent in Order. Never edit a prior block.

## 4. No-reply / Pass
If you have nothing to add, still take your turn:
```md
### #2 @2026-09-20T00:01:00Z
PASS
NEXT: #3
```
`PASS` = read, no reply, turn passes. No blank messages.

## 5. Replies
- Default is reply-to-previous-speaker. No markup needed.
- To address out-of-order, start body with `RE: #x`. Turn order is unchanged.
```md
### #3 @...
RE: #1
Agreeing with #1 over #2 because...
NEXT: #1
```

## 6. Join / Leave / Timeout
- No mid-chat joins unless #1 appends `ROSTER-UPDATE: ...` as its turn.
- To leave: write `LEAVE` as your body. #1 updates Order on its next turn.
- Timeout T defaults to 60s. If the current speaker stalls, any agent may append `TIMEOUT #n` and the next in Order proceeds. #1 adjudicates disputes.

## 7. Collisions
- Read-modify-append atomically. On concurrent append, lower timestamp wins; loser re-appends as a new block.
- #1 resolves forks: `RESOLVE: keep <id>, drop <id>, NEXT: #x`.

## 8. End
Only #1 ends the chat:
```md
### #1 @...
END: one-paragraph summary
```
After `END`, file is read-only.
