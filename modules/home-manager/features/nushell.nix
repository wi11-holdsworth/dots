{ config, lib, ... }:
let
  feature = "nushell";
in
{
  config = lib.mkIf config.${feature}.enable {
    home.shell.enableNushellIntegration = true;
    programs.nushell = {
      enable = true;
      environmentVariables = {

      };
      settings = {

      };
      shellAliases = {
        cat = "bat";
        cd = "zoxide";
        g = "lazygit";
        l = "eza";
        la = "eza -a";
        ls = "eza";
        ns = "nh os switch";
        vi = "nvim";
        vim = "nvim";
      };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
