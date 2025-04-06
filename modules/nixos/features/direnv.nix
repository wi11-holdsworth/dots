{ config, lib, ... }:
let
  feature = "direnv";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature} ";

  config = lib.mkIf cfg.enable {
    programs.${feature}.enable = true;
    programs.bash.shellInit = ''
      dv() {
        nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$1"
      }
    '';
  };
}
