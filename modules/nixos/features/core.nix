{ config, hostName, inputs, lib, pkgs, ... }:
let
  # declare the module name and its local module dependencies
  feature = "core";

  # helper functions
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled;

in {
  config = lib.mkIf enabled {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

    i18n = {
      defaultLocale = "en_AU.UTF-8";
      supportedLocales = [ "en_US.UTF-8/UTF-8" "en_AU.UTF-8/UTF-8" ];
    };

    nix = {
      optimise.automatic = true;
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [ "will" "srv" ];
      };
    };

    nixpkgs.config.allowUnfree = true;

    time.timeZone = "Australia/Melbourne";
  };

  imports = [ ../../../hosts/${hostName}/hardware-configuration.nix ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
