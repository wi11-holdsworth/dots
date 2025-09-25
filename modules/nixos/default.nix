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
  # keep-sorted start
  agenix.enable = lib.mkDefault true;
  fonts.enable = lib.mkDefault true;
  localisation.enable = lib.mkDefault true;
  network.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;
  nix-settings.enable = lib.mkDefault true;
  nixpkgs.enable = lib.mkDefault true;
  nixvim.enable = lib.mkDefault true;
  syncthing.enable = lib.mkDefault true;
  systemd-boot.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
  # keep-sorted end

  environment.systemPackages =
    with pkgs;
    [
      # keep-sorted start
      bottom # top
      broot # large directory browser
      choose # cut
      circumflex # hacker news browsing
      cointop # crypto ticker
      ddgr # web search
      dogdns # dns
      dua # du
      duf # df
      epy # ebook reading
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
      nixfmt-rfc-style # nix file formatting
      nom # stylistic nix dependency graphs
      pastel # colour generation
      pdd # datetime calculations
      pirate-get # torrenting
      procs # ps
      rates # currency conversion
      ripgrep-all # grep
      ripunzip # unzip
      sd # sed
      slides # presentations
      ticker # stock ticker
      tldr # cheat sheets
      tmpmail # temporary email address
      topydo # todo.txt helper tool
      tt # typing test
      wtfutil # terminal homepage
      xh # curl
      xxh # use shell config in remote sessions
      # keep-sorted end
    ]
    ++ (with pkgs.python312Packages; [ howdoi ]);
}
