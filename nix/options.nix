{ agentPaths }:
{ lib, ... }:
{
  options.programs.rcd-agent-skills = {
    enable = lib.mkEnableOption "rcd-agent-skills";

    agents = lib.mkOption {
      type = lib.types.listOf (lib.types.enum (builtins.attrNames agentPaths));
      default = [ ];
      description = "Agents whose skill directories should receive these skills.";
    };
  };
}
