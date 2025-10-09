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

  age.secrets."protonmail-desktop-password".file = ../../secrets/protonmail-desktop-password.age;

  home = {
    username = "${userName}";
    homeDirectory = "/home/will";
    stateVersion = "24.11";
  };
}
