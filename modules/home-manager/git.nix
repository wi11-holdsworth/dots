{
  editor,
  ...
}: let
  userName = "wi11-holdsworth";
  userEmail = "83637728+wi11-holdsworth@users.noreply.github.com";
in {
  programs.git = {
    enable = true;
    inherit userName;
    inherit userEmail;
    signing.signByDefault = true;
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "${editor}";
      push.autoSetupRemote = true;
      pull.rebase = false;
    };
  };  
}
