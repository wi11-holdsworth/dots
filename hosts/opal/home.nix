{ 
  user,
  ...
}: { 
  imports = [
    ../../modules/home-manager
  ];
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "24.11";
  };
}
