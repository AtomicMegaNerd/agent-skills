---
name: Golangci-Lint
description: Using the Linter on our Go Programs
allowed-tools: Read Edit Bash(golangci-lint:*)
---

# Golangci-Lint

## When to Activate

- Whenever we are running or configuring the linter.
- When formatting the code.

## Golangci-Lint Configuration

We want to enforce 100 column lines. This is the recommended config:

```yaml
---
version: "2"
linters:
  default: standard
  enable:
    - lll
  settings:
    lll:
      line-length: 100
      tab-width: 1
formatters:
  enable:
    - golines
  settings:
    golines:
      max-len: 100
      # Shorten single-line comments.
      shorten-comments: true
```



