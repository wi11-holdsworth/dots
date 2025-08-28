{
  config,
  inputs,
  lib,
  ...
}:
let
  feature = "nixvim";
in
{
  config = lib.mkIf config.${feature}.enable {
    environment.variables.EDITOR = "nvim";
    programs.nixvim = {
      enable = true;
      clipboard = {
        providers.wl-copy.enable = true;
        register = "unnamedplus";
      };
      colorschemes.catppuccin = {
        enable = true;
        settings.background.dark = "mocha";
      };
      dependencies = {
        tree-sitter.enable = true;
        nodejs.enable = true;
        gcc.enable = true;
      };
      diagnostic.settings.virtual_lines = true;
      opts = {
        autoindent = true;
        expandtab = true;
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        tabstop = 2;
        colorcolumn = "80";
      };
      plugins = {
        # autoclose brackets
        autoclose.enable = true;

        # completion window
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-e>" = "cmp.mapping.close()";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
            sources = [
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; }
            ];
          };
        };

        # git changes in margin
        gitsigns.enable = true;

        # opens last edit position
        lastplace.enable = true;

        # lsp servers
        lsp = {
          enable = true;
          inlayHints = true;
          servers = {
            nixd.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
            hls = {
              enable = true;
              installGhc = true;
            };
          };
        };
        lsp-format.enable = true;
        lsp-lines.enable = true;
        lsp-signature.enable = true;
        lspkind.enable = true;

        # status bar
        lualine.enable = true;

        # syntax highlighting
        treesitter.enable = true;
      };
    };
  };

  imports = [ inputs.nixvim.nixosModules.nixvim ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
