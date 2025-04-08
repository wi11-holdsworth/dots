{ config, lib, nixosConfig, ... }:
let
  # declare the module name and its local module dependencies
  feature = "bash";
  homeManagerDependencies = with config; [ ];
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
    programs = {
      # initialise bash with some aliases
      ${feature} = {
        enable = true;

        shellAliases = {
          ls = "eza --group-directories-first --icons";
          la = "ls -a";
          ll = "la -l";
          lt = "la -T";

          vi = "nvim";
          vim = "nvim";

          rf =
            "nix flake init --template 'https://flakehub.com/f/the-nix-way/dev-templates/*#rust' && direnv allow";
          dots = "cd $FLAKE && clear && ls -T && echo";
          nos = "nh os switch";
        };
      };

      # initialise starship with some pretty colours and preferential defaults
      starship = {
        enable = true;
        settings.character = {
          success_symbol = "[%](bold green) ";
          error_symbol = "[%](bold red) ";
        };
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
