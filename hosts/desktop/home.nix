{ ...

}: {
  imports = [ ../../modules/home-manager/default.nix ];

  # TODO: remove reference to username
  home = {
    username = "will";
    homeDirectory = "/home/will";
    stateVersion = "24.11";
  };
}
