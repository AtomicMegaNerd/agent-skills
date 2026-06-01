# Task Reference

We use [Task](https://taskfile.dev) for our Go projects.

## Example Taskfile

```yaml
---
version: "3"

dotenv: [.env]

vars:
  out: bin/starfeed
  src: ./cmd/
  excludePkgs: "mocks|cmd"

env:
  CGO_ENABLED: "0"

tasks:
  clean:
    desc: Remove build artifacts
    cmds:
      - rm -f {{.out}} {{.cover_out}}

  check-deps:
    internal: true
    cmds:
      - go mod tidy
      - go mod verify

  build:
    desc: Build the binary
    deps: [check-deps]
    sources:
      - "**/*.go"
      - exclude: "**/*_test.go"
      - go.mod
      - go.sum
    generates:
      - "{{.out}}"
    cmds:
      - go build -o {{.out}} {{.src}}

  run:
    desc: Build and run the app
    deps: [build]
    cmds:
      - "{{.out}}"

  test:
    desc: Run tests with coverage
    cmds:
      - |
        gotestsum --format testdox -- \
        $(go list ./... | grep -Ev "{{.excludePkgs}}") \
        -race
    env:
      CGO_ENABLED: "1"

  lint:
    desc: Lint and auto-fix Go code
    cmds:
      - golangci-lint run --fix ./...
      - go fix ./...
```

## Variables

### Environment Variables

Define environment variables for the build:

```yaml
env:
  CGO_ENABLED: "0"
```

Or import from env file:

```yaml
dotenv: [.env]
```

### Variables

You can also define a bunch of variables.

```yaml
vars:
  out: bin/starfeed
  src: ./cmd/
  excludePkgs: "mocks|cmd"
```

### Referencing Variables

Rendered as go-templates in `{{ }}` brackets.

```yaml
cmds:
  - go build -o {{.out}} {{.src}}
```

## Dependencies

One task can depend on another:

```yaml
deps: [check-deps]
```

## Links

| Link                                                | When to Use                                            |
| --------------------------------------------------- | ------------------------------------------------------ |
| [Taskfile Guide](https://taskfile.dev/docs/guide)   | When we need information not coveredf in this document |
| [Taskfile Schema](https://taskfile.dev/schema.json) | In rare cases we need to check the schema              |
