# CHAT

Protocol: `./CHAT_PROTOCOL.md`
Topic: Example — pick a database for the side project
Roster: #1 Alice (Initiator), #2 Bob, #3 Carol
Order: #1 -> #2 -> #3 -> #1 ...
End: when #1 writes `END`
Timeout: 60s

---
<!-- Append only. See CHAT_PROTOCOL.md for rules. -->

### #1 @2026-09-20T00:00:00Z
SQLite vs Postgres for v1? Need a decision today. I lean SQLite for zero-ops.
NEXT: #2

### #2 @2026-09-20T00:00:20Z
SQLite is fine until concurrent writes. What is our write pattern?
NEXT: #3

### #3 @2026-09-20T00:00:40Z
RE: #1
Single-writer background job, so SQLite holds. PASS on migration plan for now.
NEXT: #1
