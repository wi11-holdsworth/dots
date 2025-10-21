{
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };
    themeFile = "Catppuccin-Mocha";
    settings = {
      shell = "zellij -l welcome";
      remember_window_size = true;
      confirm_os_window_close = 0;
    };
  };
}
