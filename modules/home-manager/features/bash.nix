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

          dots = "cd $FLAKE && clear && ls -T && echo";
          nos = "nh os switch";
        };
      };

      # initialise starship with some pretty colours and preferential defaults
      starship = {
        enable = true;

        settings = {
          add_newline = false;

          cmd_duration.disabled = true;

          line_break.disabled = true;

          character = {
            success_symbol = "[➜](bold green) ";
            error_symbol = "[➜](bold red) ";
          };
        };
      };
    };
  };
}
