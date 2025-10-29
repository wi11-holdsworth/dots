{
  ...
}:
{
  programs.lazygit = {
    enable = true;
    settings = {
      log = {
        localBranchSortOrder = "recency";
        remoteBranchSortOrder = "recency";
      };
    };
  };
}
