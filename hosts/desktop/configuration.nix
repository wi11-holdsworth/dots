{ pkgs, inputs, ...

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

  # TODO: remove reference to username
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
      luks.devices."luks-b164af31-c1c3-4b4e-83c8-eb39802c2027".device =
        "/dev/disk/by-uuid/b164af31-c1c3-4b4e-83c8-eb39802c2027";
    };
  };

  # TODO: remove reference to hostname
  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
  };

  time.timeZone = "Australia/Melbourne";
  i18n = {
    defaultLocale = "en_AU.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "en_AU.UTF-8/UTF-8" ];
    extraLocaleSettings.LC_ALL = "en_AU.UTF-8";
  };

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  environment.systemPackages = with pkgs;
    [
      brave
      ghostty
      kiwix
      obsidian
      signal-desktop
      vlc

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
    ] ++ (with pkgs.kdePackages; [ ktorrent calligra kzones ]);

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
      extraPackages = with pkgs; [ amdvlk ];
    };
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  security.rtkit.enable = true;

  # TODO: remove reference to username
  users.users.will = {
    isNormalUser = true;
    description = "Will Holdsworth";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    optimise.automatic = true;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
