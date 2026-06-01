# Go Reference Information

## Use Modern Go API's

Always check the stdlib first. All of these are available in modern Go:

| Package | Function/Method                              | Notes                                                    |
| ------- | -------------------------------------------- | -------------------------------------------------------- |
| slices  | Contains(s, "value")                         | Test if slice contains value                             |
| slices  | Index(s, "value")                            | Returns index or -1 if not found                         |
| slices  | ContainsFunc(s, func(v string) bool { ... }) | Test with predicate                                      |
| slices  | Sort(s)                                      | Sorts in place, any ordered type                         |
| slices  | SortFunc(s, func(a, b T) int { ... })        | Custom sort with comparator                              |
| slices  | IsSorted(s)                                  | Checks if sorted                                         |
| slices  | Reverse(s)                                   | Reverses slice                                           |
| slices  | Compact(s)                                   | Removes consecutive duplicates                           |
| slices  | Delete(s, i, j)                              | Removes elements [i, j)                                  |
| slices  | Clone(s)                                     | Shallow copy                                             |
| slices  | Concat(s1, s2, s3)                           | Concatenate slices                                       |
| maps    | Keys(m)                                      | Iterator/[]K of keys                                     |
| maps    | Values(m)                                    | Iterator/[]V of values                                   |
| maps    | Clone(m)                                     | Shallow copy                                             |
| maps    | Copy(dst, src)                               | Copies all entries from src to dst                       |
| maps    | Delete(m, func(k, v T) bool { ... })         | Delete entries matching predicate                        |
| maps    | Equal(m1, m2)                                | Reports if two maps are equal                            |
| cmp     | Compare(a, b)                                | -1, 0, or 1; works on cmp.Ordered                        |
| cmp     | Or(a, b, c)                                  | First non-zero value (default-value pattern)             |
| cmp     | min(a, b)                                    | Built-in since Go 1.21                                   |
| cmp     | max(a, b)                                    | Built-in since Go 1.21                                   |
| errors  | Join(err1, err2, ...)                        | Combine multiple errors                                  |
| errors  | Is(err, ErrNotFound)                         | Works with errors.Join                                   |
| atomic  | Int64                                        | Type-safe atomic int64                                   |
| atomic  | count.Add(1)                                 | Atomically add 1                                         |
| atomic  | count.Load()                                 | Atomically load value                                    |
| atomic  | Bool                                         | Type-safe atomic boolean                                 |
| atomic  | Pointer[MyStruct]                            | Type-safe atomic pointer                                 |
| atomic  | Int32, Uint64                                | Other typed atomics                                      |
| context | WithoutCancel(ctx)                           | Detach cancellation, preserve values for background work |
| slog    | With("key", value, ...)                      | Structured logger with fields                            |
| slog    | Info("msg")                                  | Info-level log                                           |
| slog    | Debug("msg", "key", val)                     | Debug log with key-value                                 |
| slog    | With(slog.Group(...))                        | Group related fields                                     |

## Links

| Link                                                                        | When to Use                                                            |
| --------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| [Go Standard Library](https://pkg.go.dev/std)                               | When looking up functions in the standard library                      |
| [Go Release Notes](https://go.dev/doc/devel/release)                        | When checking which features are supported in a specific version of Go |
| [Go By Example](https://gobyexample.com/)                                   | Examples of idiomatic Go                                               |
| [errgroup Package](https://pkg.go.dev/golang.org/x/sync/errgroup)           | Documentation on `errgroup` package                                    |
| [semaphore Package](https://pkg.go.dev/golang.org/x/sync@v0.20.0/semaphore) | Documentation on `semaphore` package                                   |
