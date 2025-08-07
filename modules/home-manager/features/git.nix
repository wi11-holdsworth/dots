{
  config,
  lib,
  ...
}:
let
  feature = "git";
in
{
  config = lib.mkIf config.${feature}.enable {
    programs.${feature} = {
      enable = true;

      delta = {
        enable = true;
        options.theme = "Dracula";
      };

      userName = "wi11-holdsworth";
      userEmail = "83637728+wi11-holdsworth@users.noreply.github.com";

      aliases = {
        a = "add";
        aa = "add .";
        ap = "add -p";
        c = "commit --verbose";
        ca = "commit -a --verbose";
        cm = "commit -m";
        cam = "commit -a -m";
        m = "commit --amend --verbose";
        d = "diff";
        ds = "diff --stat";
        dc = "diff --cached";
        s = "status -s";
        co = "checkout";
        cob = "checkout -b";
        ps = "push";
        pl = "pull";
      };

      extraConfig = {
        init.defaultBranch = "main";

        core.editor = "nvim";

        push.autoSetupRemote = true;

        pull.rebase = false;
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
