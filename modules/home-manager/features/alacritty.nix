{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 13;
      };
      window.startup_mode = "Maximized";
      terminal.shell = {
        program = "${lib.getExe pkgs.zellij}";
        args = [ "-l=welcome" ];
      };
    };
    theme = "catppuccin_mocha";
  };
}
