{ config, lib, ... }:
let
  feature = "fish";
in
{
  config = lib.mkIf config.${feature}.enable {
    home.shell.enableFishIntegration = true;
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
      shellAliases = {
        cat = "bat";
        cd = "j";
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
