{ 
  ...

}: { 
  imports = [
    ../../modules/home-manager
  ];

  home = {
    username = "srv";
    homeDirectory = "/home/srv";
    stateVersion = "24.11";
  };
}
