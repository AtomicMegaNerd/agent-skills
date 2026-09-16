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

## Run Modes

Control whether a task runs once, always, or per unique vars:

```yaml
tasks:
  install-deps:
    run: once # runs only once per invocation
  generate:
    run: when_changed # runs once per unique set of vars
```

## For Loops

Loop over lists, matrices, sources, or generates:

```yaml
tasks:
  deploy:
    cmds:
      - for: [dev, staging, prod]
        cmd: deploy.sh {{.ITEM}}
```

## Conditional Execution

Skip a task or command when a condition fails (does not error):

```yaml
tasks:
  deploy:
    if: '[ "$CI" = "true" ]'
    cmds:
      - echo "Deploying..."
```

## Deferred Cleanup

Run a command after a task finishes (even on error). Multiple defers run in reverse order.

```yaml
tasks:
  test:
    cmds:
      - defer: docker compose down
      - docker compose up -d
      - go test ./...
```

## Required Vars with Allowed Values

Ensure variables are set to one of a predefined set:

```yaml
tasks:
  deploy:
    requires:
      vars:
        - name: ENV
          enum: [dev, staging, prod]
    cmds:
      - echo "Deploying to {{.ENV}}"
```

## Wildcard Tasks

Match multiple task names with a pattern:

```yaml
tasks:
  start-*:
    cmds:
      - docker compose up {{index .MATCH 0}}
```

## Links

| Link                                                                 | When to Use                                                                          |
| -------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| [Taskfile Guide](https://taskfile.dev/docs/guide)                    | When we need information not covered in this document                                |
| [Taskfile Schema](https://taskfile.dev/schema.json)                  | In rare cases we need to check the schema                                            |
| [Task v3.51.1](https://github.com/go-task/task/releases/tag/v3.51.1) | `absPath`, `joinEnv`, `joinUrl` template funcs; large Taskfile performance boost     |
| [Task v3.52.0](https://github.com/go-task/task/releases/tag/v3.52.0) | `secret: true` for masking vars, `use_gitignore`, `--temp-dir`, Azure DevOps remotes |
| [Task v3.53.1](https://github.com/go-task/task/releases/tag/v3.53.1) | Remote Taskfiles GA, per-command timeout, Nushell completions, faster fingerprinting |
