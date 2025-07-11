{ config, lib, ... }:
let
  feature = "shell";
in
{
  config = lib.mkIf config.${feature}.enable {
    environment.shellAliases = {
      g = "lazygit";
      ns = "nh os switch";
      rf = "nix flake init --template 'https://flakehub.com/f/the-nix-way/dev-templates/*#rust' && direnv allow";
      vi = "nvim";
      vim = "nvim";
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
