{ lib, config, ... }: {
  options = { git.enable = lib.mkEnableOption "enables git"; };

  config = let
    userName = "wi11-holdsworth";
    userEmail = "83637728+wi11-holdsworth@users.noreply.github.com";

  in {
    programs.git = {
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
