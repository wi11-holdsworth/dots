{ 
  ...

}: { 
  imports = [
    ../../modules/home-manager/default-server.nix
  ];

  home = {
    username = "srv";
    homeDirectory = "/home/srv";
    stateVersion = "24.11";
  };
}
