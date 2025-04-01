{ 
  ...

}: { 
  imports = [
    ../../modules/home-manager/default-desktop.nix
  ];

  # TODO: remove reference to username
  home = {
    username = "will";
    homeDirectory = "/home/will";
    stateVersion = "24.11";
  };
}
