{
  lib,
  ...
}:
{
  # allow packages with non-free licenses
  nixpkgs.config.allowUnfree = true;

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
      allowed-users = [ "@wheel" ];
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
