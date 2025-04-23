{
  config,
  lib,
  nixosConfig,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "git";
  homeManagerDependencies = with config; [ ];
  nixosDependencies = with nixosConfig; [
    core
    nixvim
  ];
  userName = "wi11-holdsworth";
  userEmail = "83637728+wi11-holdsworth@users.noreply.github.com";

  # helper functions
  homeManagerDependenciesEnabled = (lib.all (dep: dep.enable) homeManagerDependencies);
  nixosDependenciesEnabled = (lib.all (dep: dep.enable) nixosDependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && nixosDependenciesEnabled && homeManagerDependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    programs.${feature} = {
      enable = true;

      inherit userName;
      inherit userEmail;

      extraConfig = {
        init.defaultBranch = "main";

        core.editor = "nvim";

        push.autoSetupRemote = true;

        pull.rebase = false;
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
