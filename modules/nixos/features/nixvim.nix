{
  config,
  inputs,
  lib,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "nixvim";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled {
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
      colorschemes.catppuccin = {
        enable = true;
        settings.background.dark = "mocha";
      };
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

  imports = [ inputs.nixvim.nixosModules.nixvim ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
