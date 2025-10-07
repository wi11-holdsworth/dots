{
  userName,
  ...
}:
{
  imports = [ ../../modules/home-manager/default.nix ];

  # reusable modules

  # keep-sorted start
  desktop.enable = true;
  dev.enable = true;
  # keep-sorted end 

  # config

  home = {
    username = "${userName}";
    homeDirectory = "/home/will";
    stateVersion = "24.11";
  };
}
