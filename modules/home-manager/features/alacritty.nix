{
  config,
  lib,
  nixosConfig,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "alacritty";
  homeManagerDependencies = with config; [ ];
  nixosDependencies = with nixosConfig; [ core ];

  # helper functions
  homeManagerDependenciesEnabled = (lib.all (dep: dep.enable) homeManagerDependencies);
  nixosDependenciesEnabled = (lib.all (dep: dep.enable) nixosDependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && nixosDependenciesEnabled && homeManagerDependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    programs.alacritty = {
      enable = true;
      theme = "catppuccin_mocha";
      settings = {
        window.startup_mode = "fullscreen";
        terminal.shell = {
          program = "zellij";
          args = [
            "-l"
            "welcome"
          ];
        };
        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font";
            style = "italic";
          };
          bold_italic = {
            family = "JetBrainsMono Nerd Font";
            style = "bold_italic";
          };
          size = 13;
        };
      };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
