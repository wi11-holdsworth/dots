{ 
  ...

}: { 
  imports = [
    ../../modules/home-manager/default.nix
  ];

  home = {
    username = "will";
    homeDirectory = "/home/will";
    stateVersion = "24.11";
  };
}
