# rcd-agent-skills

A collection of basic skills.

Lots more to come!

## Home Manager

Add this repository as a flake input and import its Home Manager module:

```nix
inputs.rcd-agent-skills.url = "github:AtomicMegaNerd/agent-skills";

# In your Home Manager modules:
imports = [ inputs.rcd-agent-skills.homeManagerModules.default ];
programs.rcd-agent-skills.agent = "opencode";
```

The `programs.rcd-agent-skills.agent` option is required and currently supports
`opencode`. The module links each skill directory into `~/.config/opencode/skills`.

## List of Tasks

- [Go](./rcd-golang/SKILL.md)
- [Golangci-lint](./rcd-golangci-lint/SKILL.md)
- [Task](./rcd-go-task/SKILL.md)

## Credits

Thanks to the following sources for inspiration:

- [https://github.com/spf13/go-skills](https://github.com/spf13/go-skills) the Go skill is largely
  based on this.
