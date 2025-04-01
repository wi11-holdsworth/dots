{ 
  pkgs,
  inputs,
  ... 

}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/default-server.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  # TODO: remove reference to username
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.srv = import ./home.nix;
  };

  # TODO: remove reference to username
  age.identityPaths = [ "/home/srv/.ssh/id_ed25519" ];

  boot.loader = { 
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  networking = {
    hostName = "server";
    firewall.enable = true;
  }; 

  time.timeZone = "Australia/Melbourne";

  i18n.defaultLocale = "en_AU.UTF-8";

  environment.systemPackages = with pkgs; [
    nh
    gh
    eza
    ripgrep-all
    fd
    dust
    bat
    nom
    delta
    zellij
  ];

  # TODO: remove reference to username
  environment.sessionVariables = {
    FLAKE = "/home/srv/.dots";
    EDITOR = "nvim";
  };

  services = { 
    openssh.enable = true;
    glances.enable = true;
  };

  virtualisation.docker.enable = true;
  
  # TODO: remove reference to username
  users.users.srv = {
    isNormalUser = true;

    home = "/home/srv";

    shell = pkgs.bash;

    extraGroups = [ "wheel" "docker" ];
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    optimise.automatic = true;
  };

  system.stateVersion = "24.11";
}

