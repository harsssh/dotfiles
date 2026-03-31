---
name: clipboard
description: Copy commands or full text from the most recent response to the clipboard
allowed-tools: Bash(echo * | pbcopy)
---

Analyze your most recent response (the response immediately before the user invoked `/clipboard`) and copy the appropriate content to the clipboard via `pbcopy`.

Procedure:
1. Check if the response contains executable shell commands.
2. If commands exist: extract only the commands, join with newlines, and copy.
3. If no commands exist: the conversation is likely about drafting or refining text. Copy the full final version of that text.

Rules:
- "Commands" means executable shell commands. Inline code references, file contents, and code snippets that are not shell commands do not count.
- When copying commands, exclude prose and comments. Join multiple commands with newlines.
- When copying text, copy the final complete version as-is. Do not include surrounding prose like "here is the revised version".
- Do NOT add any extra text to the clipboard content.
- After copying, briefly tell the user what was copied (e.g. "2 commands" or "revised text").
