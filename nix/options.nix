{ lib, ... }:
{
  options.programs.rcd-agent-skills = {
    enable = lib.mkEnableOption "rcd-agent-skills";
  };
}
