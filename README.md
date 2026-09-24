# RCD Agent Skills

A collection of basic agent skills.

## List of Skills

- [rcd-golang](./rcd-golang/SKILL.md)
- [rcd-golangci-lint](./rcd-golangci-lint/SKILL.md)
- [rcd-go-task](./rcd-go-task/SKILL.md)

## Nix Setup (Home Manager)

Add the repository to your main flake's `inputs` and add `rcd-agent-skills` to the flake output:

```nix
rcd-agent-skills.url = "github:AtomicMegaNerd/agent-skills";
```

In the `modules` list passed to your existing Home Manager configuration, add the module and enable
it for the agents you use:

```nix
modules = [
  ./home.nix
  rcd-agent-skills.homeManagerModules.default
];
```

Then in your home-manager config:

```nix
{
    programs.rcd-agent-skills = {
      enable = true;
      agents = [ "opencode" ];
    };
}
```
