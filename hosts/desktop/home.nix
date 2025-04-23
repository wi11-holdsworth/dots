{
  config,
  pkgs,
  userName,
  ...
}:
{
  imports = [ ../../modules/home-manager/default.nix ];

  home = {
    username = "${userName}";
    homeDirectory = "/home/will";
    stateVersion = "24.11";
  };
}
