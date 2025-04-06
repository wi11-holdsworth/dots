{ ...

}: {
  imports = [ ../../modules/home-manager/default.nix ];

  # TODO: remove reference to username
  home = {
    username = "srv";
    homeDirectory = "/home/srv";
    stateVersion = "24.11";
  };
}
