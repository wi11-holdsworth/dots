{
  userName,
  ...
}:
{
  imports = [ ../../modules/home-manager/default.nix ];

  # reusable modules

  desktop.enable = true;

  # config

  home = {
    username = "${userName}";
    homeDirectory = "/home/will";
    stateVersion = "24.11";
  };
}
