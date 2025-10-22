{
  # keep-sorted start
  pkgs,
  util,
  # keep-sorted end
  ...
}:
{
  imports = util.toImports ./features [
    # keep-sorted start
    "agenix"
    "fonts"
    "localisation"
    "network"
    "nh"
    "nix-settings"
    "nixpkgs"
    "nixvim"
    "syncthing"
    "systemd-boot"
    "tailscale"
    # keep-sorted end
  ];

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
      mprocs # run long running commands and monitor output
      navi # cheatsheet browser
      nb # note taking
      nil # nix language server
      nixd # nix language server
      nixfmt-rfc-style # nix file formatting
      nom # stylistic nix dependency graphs
      pastel # colour generation
      pdd # datetime calculations
      pirate-get # torrenting
      pre-commit # declarative pre-commit installer and runner
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
