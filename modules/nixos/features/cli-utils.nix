{ config, lib, pkgs, ... }:
let
  # declare the module name and its local module dependencies
  feature = "cli-utils";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {
    environment.systemPackages = with pkgs; [
      bat
      dust
      eza
      fd
      nom
      ripgrep-all
      zellij
    ];
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
