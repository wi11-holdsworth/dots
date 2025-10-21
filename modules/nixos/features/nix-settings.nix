{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 20d";
      persistent = true;
    };
    optimise = {
      automatic = true;
      persistent = true;
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "will"
        "srv"
      ];
    };
  };
}
