{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # keep-sorted start
    heroic
    lutris
    mangohud
    nexusmods-app
    prismlauncher
    protonup-qt
    wine
    wine64
    winetricks
    # keep-sorted end
  ];

  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  services.lact = {
    enable = true;
    settings = { };
  };

  # latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
