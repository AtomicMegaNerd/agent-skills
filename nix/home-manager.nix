{ config, lib, ... }:
let
  cfg = config.programs.rcd-agent-skills;

  skillsDir = ".agents/skills";

  skills = {
    rcd-golang = ../rcd-golang;
    rcd-golangci-lint = ../rcd-golangci-lint;
    rcd-go-task = ../rcd-go-task;
  };
in
{
  imports = [ ./options.nix ];

  config = lib.mkIf cfg.enable {
    home.file = lib.mapAttrs' (name: source: {
      name = "${skillsDir}/${name}";
      value = { inherit source; };
    }) skills;
  };
}
