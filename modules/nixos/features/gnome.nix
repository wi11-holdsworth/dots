{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "gnome";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };

    environment = {
      systemPackages = with pkgs; [
        endeavour # todo app
      ];

      # https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
      gnome.excludePackages = with pkgs; [
        # baobab # disk usage analyzer
        # cheese # photo booth
        # eog # image viewer
        epiphany # web browser
        gedit # text editor
        # simple-scan # document scanner
        totem # video player
        yelp # help viewer
        evince # document viewer
        # file-roller # archive manager
        geary # email client
        seahorse # password manager

        # these should be self explanatory
        gnome-calculator
        gnome-calendar
        gnome-characters
        gnome-clocks
        gnome-contacts
        gnome-font-viewer
        gnome-logs
        gnome-maps
        gnome-music
        gnome-photos
        # gnome-screenshot
        # gnome-system-monitor
        gnome-terminal
        gnome-weather
        # gnome-disk-utility
        gnome-connections
      ];
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
