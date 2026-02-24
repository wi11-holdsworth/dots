{
  userName,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      # keep-sorted start block=yes
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
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      user = {
        name = "Will Holdsworth";
        email = "me@fi33.buzz";
      };
      # keep-sorted end
    };
    signing = {
      key = "/home/${userName}/.ssh/git_signature.pub";
      format = "ssh";
      signByDefault = true;
    };
  };
}
