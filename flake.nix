{
  description = "rcd-agent-skills";

  outputs = { ... }: {
    homeManagerModules.default = import ./nix/home-manager.nix;
  };
}
