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

  config = lib.mkIf cfg.enable {
    xdg.configFile = lib.foldl' (
      files: agent:
      files
      // lib.mapAttrs' (name: source: {
        name = "${agentPaths.${agent}}/${name}";
        value = { inherit source; };
      }) skills
    ) { } cfg.agents;
  };
}
