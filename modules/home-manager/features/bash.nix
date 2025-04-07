{ config, lib, ... }:
let
  feature = "bash";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
    programs = {
      # initialise bash with some aliases
      ${feature} = {
        enable = true;

        shellAliases = {
          ls = "eza --group-directories-first --icons";
          la = "ls -a";
          ll = "la -l";
          lt = "la -T";

          vi = "nvim";
          vim = "nvim";

          rf =
            "nix flake init --template 'https://flakehub.com/f/the-nix-way/dev-templates/*#rust' && direnv allow && cargo init";
          dots = "cd $FLAKE && clear && ls -T && echo";
          nos = "nh os switch";
        };
      };

      # initialise starship with some pretty colours and preferential defaults
      starship.enable = true;
    };
  };
}
