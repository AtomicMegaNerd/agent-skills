{ config, lib, ... }:
let
  cfg = config.programs.rcd-agent-skills;

  # Add an agent here to make its skills directory selectable.
  agentPaths = {
    opencode = "opencode/skills";
  };

  skills = {
    rcd-golang = ../rcd-golang;
    rcd-golangci-lint = ../rcd-golangci-lint;
    rcd-go-task = ../rcd-go-task;
  };
in
{
  imports = [ (import ./options.nix { inherit agentPaths; }) ];

  config.xdg.configFile = lib.mapAttrs' (name: source: {
    name = "${agentPaths.${cfg.agent}}/${name}";
    value = { inherit source; };
  }) skills;
}
