{ config, lib, ... }:
let
  feature = "git";
  userName = "wi11-holdsworth";
  userEmail = "83637728+wi11-holdsworth@users.noreply.github.com";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
    programs.${feature} = {
      enable = true;

      inherit userName;
      inherit userEmail;

      extraConfig = {
        init.defaultBranch = "main";

        core = {
          editor = "nvim";
          pager = "delta";
        };

        push.autoSetupRemote = true;

        pull.rebase = false;
      };
    };
  };
}
