{
  pkgs,
  ...
}:
{
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  environment = {
    # https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
    gnome.excludePackages = with pkgs; [
      # keep-sorted start
      # baobab # disk usage analyzer
      # cheese # photo booth
      # eog # image viewer
      epiphany # web browser
      evince # document viewer
      # file-roller # archive manager
      geary # email client
      gedit # text editor
      gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-clocks
      # gnome-disk-utility
      gnome-connections
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
      seahorse # password manager
      # simple-scan # document scanner
      totem # video player
      yelp # help viewer
      # keep-sorted end
    ];
    systemPackages = with pkgs; [
      gnome-tweaks
      bibata-cursors
    ];
  };
}
