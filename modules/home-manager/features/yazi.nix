{
  pkgs,
  ...
}:
{
  programs.yazi = {
    enable = true;
    plugins = {
      # keep-sorted start
      diff = pkgs.yaziPlugins.diff;
      git = pkgs.yaziPlugins.git;
      mediainfo = pkgs.yaziPlugins.mediainfo;
      mount = pkgs.yaziPlugins.mount;
      ouch = pkgs.yaziPlugins.ouch;
      relative-motions = pkgs.yaziPlugins.relative-motions;
      restore = pkgs.yaziPlugins.restore;
      rich-preview = pkgs.yaziPlugins.rich-preview;
      starship = pkgs.yaziPlugins.starship;
      vcs-files = pkgs.yaziPlugins.vcs-files;
      yatline-githead = pkgs.yaziPlugins.yatline-githead;
      # keep-sorted end
    };
  };
}
