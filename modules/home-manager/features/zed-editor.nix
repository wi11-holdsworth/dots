{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "zed-editor";
in
{
  config = lib.mkIf config.${feature}.enable {
    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor-fhs;
      extensions = [
        # keep-sorted start
        "catppuccin"
        "catppuccin-icons"
        "codebook"
        "emmet"
        "git-firefly"
        "haskell"
        "html"
        "nix"
        # keep-sorted end
      ];
      extraPackages = with pkgs; [
        # keep-sorted start
        haskell-language-server
        nil
        nixd
        package-version-server
        rust-analyzer
        # keep-sorted end
      ];
      installRemoteServer = true;
      userSettings = {
        # keep-sorted start block=yes
        base_keymap = "VSCode";
        buffer_font_family = "JetBrainsMono Nerd Font";
        buffer_font_size = 15;
        disable_ai = true;
        icon_theme = "Catppuccin Mocha";
        inlay_hints = {
          enabled = true;
          show_value_hints = true;
          show_type_hints = true;
          show_parameter_hints = true;
          show_other_hints = true;
          show_background = false;
          edit_debounce_ms = 700;
          scroll_debounce_ms = 50;
          toggle_on_modifiers_press = {
            control = false;
            alt = false;
            shift = false;
            platform = false;
            function = false;
          };
        };
        # https://wiki.nixos.org/wiki/Zed#rust-analyzer
        lsp.rust-analyzer.binary.path = lib.getExe pkgs.rust-analyzer;
        minimap = {
          show = "auto";
        };
        preferred_line_length = 80;
        relative_line_numbers = true;
        soft_wrap = "preferred_line_length";
        tab_bar = {
          show_nav_history_buttons = false;
        };
        tab_size = 2;
        tabs = {
          file_icons = true;
          git_status = true;
        };
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        theme = {
          mode = "system";
          light = "One Light";
          dark = "Catppuccin Mocha";
        };
        ui_font_family = "JetBrainsMono Nerd Font";
        ui_font_size = 16;
        vim_mode = true;
        # keep-sorted end
      };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
