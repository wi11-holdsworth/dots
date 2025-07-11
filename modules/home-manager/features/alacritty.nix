{
  config,
  lib,
  ...
}:
let
  feature = "alacritty";
in
{
  config = lib.mkIf config.${feature}.enable {
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
