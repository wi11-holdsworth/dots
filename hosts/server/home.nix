{
  userName,
  ...
}:
{
  imports = [ ../../modules/home-manager/default.nix ];

  home = {
    username = "${userName}";
    homeDirectory = "/home/srv";
    stateVersion = "24.11";
  };
}
