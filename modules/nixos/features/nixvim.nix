{ config, inputs, lib, ... }:
let
  feature = "nixvim";
  cfg = config.${feature};

in {
  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
    programs.${feature} = {
      enable = true;
      opts = {
        shiftwidth = 2;
        number = true;
        relativenumber = true;
        autoindent = true;
        tabstop = 2;
        expandtab = true;
      };
      colorschemes.ayu.enable = true;
      plugins = {
        cmp = {
          enable = true;
          autoEnableSources = true;
        };
        cmp-nvim-lsp.enable = true;
        cmp_luasnip.enable = true;
        cmp-treesitter.enable = true;
        cmp-async-path.enable = true;
        cmp-npm.enable = true;
        cmp-emoji.enable = true;
        cmp-dictionary.enable = true;
        cmp-calc.enable = true;
        lsp = {
          enable = true;
          servers.nixd.enable = true;
        };
        lsp-format.enable = true;
        autoclose.enable = true;
        lualine.enable = true;
        luasnip.enable = true;
        treesitter.enable = true;
        lastplace.enable = true;
      };
    };
  };
}
