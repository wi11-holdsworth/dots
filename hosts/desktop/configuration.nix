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

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.will = import ./home.nix;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
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
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono 
  ];
 
  environment.systemPackages = with pkgs; [
    brave
    gh
    signal-desktop
    ghostty

    # uutils
    bat
    dust
    delta
    eza
    fd
    nom
    ripgrep-all
    zellij
  ];

  services = {
    displayManager.sddm.wayland.enable = true;
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
      extraPackages = with pkgs; [
        amdvlk
      ];
    };
  };

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
