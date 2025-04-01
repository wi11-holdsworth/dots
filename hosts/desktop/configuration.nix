{
  pkgs,
  inputs,
  ...

}: {
  imports = [
      ./hardware-configuration.nix
      ../../modules/nixos/default-desktop.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  # gaming
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.will = import ./home.nix;
    backupFileExtension = "backup";
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_testing;
    initrd = {
      kernelModules = [ "amdgpu" ];
      luks.devices."luks-b164af31-c1c3-4b4e-83c8-eb39802c2027".device = "/dev/disk/by-uuid/b164af31-c1c3-4b4e-83c8-eb39802c2027";
    };
  };

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
  };

  time.timeZone = "Australia/Melbourne";

  i18n = {
    defaultLocale = "en_AU.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "en_AU.UTF-8";
      LC_ALL = "en_AU.UTF-8";
      LC_CTYPE = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_COLLATE = "en_AU.UTF-8";
      LC_TIME = "en_GB.UTF-8";
      LC_MESSAGES = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LANG = "en_AU.UTF-8";
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono 
  ];
 
  environment.systemPackages = with pkgs; [
    brave
    ghostty
    kiwix
    obsidian
    signal-desktop

    # dev    
    gh
    nixfmt
    vscode

    # gaming
    mangohud
    protonup-qt
    lutris
    heroic

    # uutils
    bat
    dust
    delta
    eza
    fd
    nom
    ripgrep-all
    zellij
  ] ++ (with pkgs.kdePackages; [
    dragon
    ktorrent
    calligra
    kzones
  ]);

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    pulseaudio.enable = false;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
      ];
    };
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  security.rtkit.enable = true;

  users.users.will = {
    isNormalUser = true;
    description = "Will Holdsworth";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    optimise.automatic = true;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
