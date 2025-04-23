{ config, lib, nixosConfig, ... }:
let
  # declare the module name and its local module dependencies
  feature = "gh";
  homeManagerDependencies = with config; [ git ];
  nixosDependencies = with nixosConfig; [ core nixvim ];

  # helper functions
  homeManagerDependenciesEnabled =
    (lib.all (dep: dep.enable) homeManagerDependencies);
  nixosDependenciesEnabled = (lib.all (dep: dep.enable) nixosDependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && nixosDependenciesEnabled
    && homeManagerDependenciesEnabled;

in {
  config = lib.mkIf enabled {
    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        editor = "nvim";
        aliases = {
          a = "add";
          ap = "add -p";
          c = "commit --verbose";
          ca = "commit -a --verbose";
          cm = "commit -m";
          cam = "commit -a -m";
          m = "commit --amend --verbose";
          d = "diff";
          ds = "diff --stat";
          dc = "diff --cached";
          s = "status -s";
          co = "checkout";
          cob = "checkout -b";
        };
      };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
