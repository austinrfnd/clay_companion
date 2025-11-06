---
description: Analyze git diff and create an intelligent commit message without Claude attribution
---

Launch the commit-message-generator subagent to analyze the current git diff and create an appropriate commit message.

The subagent will:
1. Check git status and staged changes
2. Analyze the diff to understand what was changed
3. Generate a clear, concise commit message following conventional commit format
4. Create the commit WITHOUT any Claude co-authorship attribution

Use the Task tool with subagent_type="commit-message-generator" and provide this prompt:

"Analyze the current git changes (staged or unstaged) and create an appropriate commit message. Follow conventional commit format (type(scope): subject). Do not include any Claude attribution or co-authorship. Just analyze the diff and commit with a clear message."
