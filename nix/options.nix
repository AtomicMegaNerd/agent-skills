{ agentPaths }:
{ lib, ... }:
{
  options.programs.rcd-agent-skills.agent = lib.mkOption {
    type = lib.types.enum (builtins.attrNames agentPaths);
    description = "The agent whose skills directory should receive these skills.";
  };
}
