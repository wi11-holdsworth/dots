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

  environment.systemPackages = with pkgs; [
    # keep-sorted start
    bottom # process viewer
    broot # large directory browser
    dogdns # dns
    fd # find
    fselect # find with sql syntax
    fx # json processor and viewer
    fzf # fuzzy finder
    glow # markdown viewer
    gping # pretty ping
    grex # regular expression generator
    hexyl # hexadecimal viewer
    hyperfine # benchmarking tool
    keep-sorted # alphabetical formatter
    lazygit # git tui
    mprocs # run long running commands and monitor output
    navi # cheatsheet browser
    nb # note taking
    nixfmt-rfc-style
    nom # stylistic nix dependency graphs
    procs # ps
    ripgrep-all # grep
    ripunzip # unzip
    sd # sed
    slides # presentations
    ticker # stock ticker
    tldr
    tmpmail # temporary email address
    tt # typing test
    wtfutil # terminal homepage
    xh # curl
    # keep-sorted end
  ];
}
