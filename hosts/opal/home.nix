{ 
  ...

}: { 
  imports = [
    ../../modules/home-manager/default.nix
  ];

  home = {
    username = "srv";
    homeDirectory = "/home/srv";
    stateVersion = "24.11";
  };
}
