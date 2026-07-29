---
name: go
description: A skill for effective Go programming
allowed-tools: Read Edit Write Glob Grep
---

# Idiomatic Go

Idiomatic Go patterns and best practices (Go >=1.26).

## When to Activate

- Writing new Go code
- Reviewing or auditing existing Go code
- Refactoring Go code
- Designing Go packages, modules, or APIs

## Core Principles

- Favour simplicity over abstraction and cleverness. The code must be as simple as possible.
- Design types so their zero value is immediately usable without initialization.
- Return early on errors
- Avoid `else` blocks for the main logic wherever possible
- Avoid nesting loops and if/else as much as possible

## Package Organization

- Avoid deeply nested directory trees
- The `internal/` package prevents other modules from importing the code inside it. Use sparingly

## Interfaces

- Write concrete types first
- Only define interfaces when multiple types need to be used interchangeably by a consumer
- Interfaces belong in _consuming_ package not _implementing_ package
- Return concrete struct so callers aren't forced to use type assertions to access fields or methods

## Concurrency Patterns

- Don't use mutexes to protect shared data if the data can be passed over a channel
- Channels orchestrate execution; mutexes serialize execution.
- Every `go func()` must have clear exit condition, managed by `context.Context` or closed channel.
- Use errgroup from `golang.org/x/sync/errgroup` package instead of standard waitgroups
- If you need to limit concurrency use a semaphore from the `golang.org/x/sync/semaphore` package.

### Semaphore Example

```go
func FetchAll(urls []string, maxConcurrent int) error {
    // url := url <- THIS IS NEVER REQUIRED IN GO >= 1.22!
    sem := semaphore.NewWeighted(maxConcurrent)
    g, ctx := errgroup.WithContext(context.Background())

    for _, url := range urls {
        if err := sem.Acquire(ctx, 1); err != nil {
          return err
        }

        g.Go(func() error {
            defer sem.Release(1)
            return fetch(ctx, url)
        })
    }

    return g.Wait()
}
```

## Configuration and Struct Design

Use **Functional Options** pattern when a struct has many optional config params

```go
type Server struct {
    addr    string
    timeout time.Duration
}

type Option func(*Server)

func WithTimeout(d time.Duration) Option {
    return func(s *Server) { s.timeout = d }
}

func NewServer(addr string, opts ...Option) *Server {
    s := &Server{
        addr:    addr,
        timeout: 30 * time.Second, // Sane default
    }
    for _, opt := range opts {
        opt(s)
    }
    return s
}
```

## Error Handling

- Errors aren't exceptions to be caught; they are values to be handled. Check them explicitly.
- When returning error, add context about what code was trying to do.
- Use `errors.Is` / `errors.As` instead of string matching.

## Testing Patterns

- Use standard library `testing` package
- Always use table tests; iterate over a slice of structs using `t.Run()`.
- Always call `t.Helper()` in helper funcs in tests
- Leverage Go's implicit interfaces to write simple, manual mocks
- For comparing complex structs or maps, use `github.com/google/go-cmp/cmp` instead of
  `reflect.DeepEqual`
- Use `t.Parallel` in table tests when safe

## Generics (Go 1.18+)

- Generics exist to eliminate duplicated algorithms, not to create type hierarchies
- Do not use generics for inheritance or polymorphism
- **Do not** create generic base types, generic services, or generic repositories.
- **Do not** use `any` as a constraint to mean "I don't know the type yet"
- **Do** use `comparable` when you need map keys or equality checks.
- **Do** use `cmp.Ordered` when you need `<`, `>`, `<=`, `>=`.

## Logging

- Always use `log/slog` from the stdlib.
- Pass `*slog.Logger` as dependency; never use package-level global beyond main
- Never log and return an error at the same time (double logging).

## Stdlib

- Use the new `slices`, `maps`, `cmp`, and `log/slog` packages.

## Other Modern Patterns

Always use modern syntax and best practices.

- Range over integer syntax `for i := range 10`
- Use `any` instead of `interface{}`
- range variables are now per-iteration (no need to shadow loop variables in closures)

## Reference

More information here.

See [./references/reference.md](./references/reference.md)
