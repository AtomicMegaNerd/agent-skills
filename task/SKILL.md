---
name: Go Task
description: Using the Task build tooling for Go
allowed-tools: Read Edit Write Glob Grep Bash(task:*)
---

# Task Go Build Tool

## When to Activate

- When you need to run the build, the linters or the tests.

## Initializing a new project

```bash
task --init
```

This creates a new `Taskfile.yml` file which is the default for Go projects.

## Basics

To any any task (replace <TASKNAME> with the name of the task.

```bash
task <TASKNAME>
```

## Commonly Used Tasks

## Build

```bash
task build
```

## Run Tests

```bash
task test
```

## Run Lints

```bash
task lint
```

## References

[./references/reference.md](./references/reference.md)
