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
        p = "push";
      };

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
