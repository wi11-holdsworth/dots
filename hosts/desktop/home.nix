{ 
  ...

}: { 
  imports = [
    ../../modules/home-manager/default-desktop.nix
  ];

  home = {
    username = "will";
    homeDirectory = "/home/will";
    stateVersion = "24.11";
  };
}
