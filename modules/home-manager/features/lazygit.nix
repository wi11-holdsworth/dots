{
  ...
}:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git.overrideGpg = true;
      log = {
        localBranchSortOrder = "recency";
        remoteBranchSortOrder = "recency";
      };
    };
  };
}
