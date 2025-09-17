{ config, lib, ... }:
let
  feature = "obsidian";
in
{
  config = lib.mkIf config.${feature}.enable {
    programs.obsidian = {
      enable = true;
      defaultSettings = {
        app = {
          tabSize = 2;
          trashOption = "local";
          alwaysUpdateLinks = true;
          attachmentFolderPath = "/";
          defaultViewMode = "preview";
          vimMode = true;
          showLineNumber = true;
        };
        appearance = {
          monospaceFontFamily = "JetBrainsMono Nerd Font";
          interfaceFontFamily = "JetBrainsMono Nerd Font";
          textFontFamily = "JetBrainsMono Nerd Font";
          nativeMenus = false;
          cssTheme = "Catppuccin";
          showRibbon = false;
        };
        communityPlugins = [
          # keep-sorted start
          "obsidian-livesync"
          "oz-clear-unused-images"
          "obsidian-editor-shortcuts"
          "tag-wrangler"
          "virtual-linker"
          "pdf-plus"
          "obsidian-excalidraw-plugin"
          "obsidian-relative-line-numbers"
          # keep-sorted end
        ];
        corePlugins = [
          # keep-sorted start
          "backlink"
          "bases"
          "bookmarks"
          "canvas"
          "command-palette"
          "daily-notes"
          "editor-status"
          "file-explorer"
          "file-recovery"
          "global-search"
          "graph"
          "markdown-importer"
          "note-composer"
          "outgoing-link"
          "outline"
          "page-preview"
          "properties"
          "random-note"
          "slash-command"
          "slides"
          "switcher"
          "tag-pane"
          "templates"
          "word-count"
          "workspaces"
          "zk-prefixer"
          # keep-sorted end
        ];
        hotkeys = {
          "editor:swap-line-down" = [
            {
              "modifiers" = [ "Alt" ];
              "key" = "ArrowDown";
            }
          ];
          "editor:swap-line-up" = [
            {
              "modifiers" = [ "Alt" ];
              "key" = "ArrowUp";
            }
          ];
          "app:toggle-left-sidebar" = [
            {
              "modifiers" = [
                "Mod"
                "Shift"
              ];
              "key" = "/";
            }
          ];
          "app:toggle-right-sidebar" = [
            {
              "modifiers" = [
                "Mod"
                "Shift"
              ];
              "key" = "\\";
            }
          ];
          "window:reset-zoom" = [
            {
              "modifiers" = [ "Mod" ];
              "key" = "0";
            }
          ];
          "app:go-back" = [
            {
              "modifiers" = [ "Alt" ];
              "key" = "ArrowLeft";
            }
          ];
          "app:go-forward" = [
            {
              "modifiers" = [ "Alt" ];
              "key" = "ArrowRight";
            }
          ];
        };
      };
    };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
