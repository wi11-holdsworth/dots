{
  lib,
  pkgs,
  ...
}:
let
  featureBundler =
    featuresDir:
    map (name: featuresDir + "/${name}") (builtins.attrNames (builtins.readDir featuresDir));
in
{
  imports = (featureBundler ./bundles) ++ (featureBundler ./features);

  agenix.enable = lib.mkDefault true;
  fonts.enable = lib.mkDefault true;
  home-manager.enable = lib.mkDefault true;
  localisation.enable = lib.mkDefault true;
  network.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;
  nix-settings.enable = lib.mkDefault true;
  nixpkgs.enable = lib.mkDefault true;
  nixvim.enable = lib.mkDefault true;
  syncthing.enable = lib.mkDefault true;
  systemd-boot.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;

  # cli utils
  environment.systemPackages = with pkgs; [
    dua # disk use analyser
    fd # find
    hyperfine # benchmarking tool
    lazygit # git tui
    mprocs # run long running commands and monitor output
    nom
    nixfmt-rfc-style
    presenterm # presentations
    ripgrep-all # grep
    ripunzip
    wiki-tui # wikipedia tui
    xh # curl
  ];
}
