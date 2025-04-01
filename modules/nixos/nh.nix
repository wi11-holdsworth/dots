{
  ...

}: {
  # TODO: remove reference to username
  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "/home/will/.dots";
  };
}
