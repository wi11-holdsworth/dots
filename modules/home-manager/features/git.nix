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
        # keep-sorted start
        a = "add";
        aa = "add .";
        ap = "add -p";
        c = "commit --verbose";
        ca = "commit -a --verbose";
        cam = "commit -a -m";
        cm = "commit -m";
        co = "checkout";
        cob = "checkout -b";
        d = "diff";
        dc = "diff --cached";
        ds = "diff --stat";
        m = "commit --amend --verbose";
        pl = "pull";
        ps = "push";
        s = "status -s";
        # keep-sorted end
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
