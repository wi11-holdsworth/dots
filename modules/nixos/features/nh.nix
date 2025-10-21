{
  userName,
  ...
}:
{
  programs.nh = {
    enable = true;
    # clean.enable = true;
    flake = "/home/${userName}/.dots";
  };
}
