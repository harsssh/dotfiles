---
name: clipboard
description: Copy commands from the most recent response to the clipboard
disable-model-invocation: true
allowed-tools: Bash(echo * | pbcopy)
---

Extract only shell commands from your most recent response (the response immediately before the user invoked `/clipboard`). Combine them into a single newline-separated string, then pipe it to `pbcopy`.

Rules:
- Include only executable shell commands. Exclude prose, comments, file contents, and code that is not a shell command.
- If there are multiple commands, join them with newlines.
- If there are no commands in the previous response, tell the user and do nothing.
- Do NOT add any extra text to the clipboard content.
