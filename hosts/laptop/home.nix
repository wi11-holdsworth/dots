{
  # keep-sorted start
  userName,
  util,
  # keep-sorted end
  ...
}:
{
  imports = [
    ../../modules/home-manager/default.nix
  ]
  ++ (util.toImports ../../modules/home-manager/bundles [
    # keep-sorted start
    "desktop"
    "dev"
    # keep-sorted end
  ]);

  age.secrets."protonmail-laptop-password".file = ../../secrets/protonmail-laptop-password.age;

  home = {
    username = "${userName}";
    homeDirectory = "/home/will";
    stateVersion = "24.11";
  };
}
