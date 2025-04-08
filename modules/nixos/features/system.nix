{ config, hostName, inputs, lib, pkgs, ... }:
let
  feature = "system";
  cfg = config.${feature};

in {
  imports = [ ../../../hosts/${hostName}/hardware-configuration.nix ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

    i18n = {
      defaultLocale = "en_AU.UTF-8";
      extraLocaleSettings.LC_ALL = "en_AU.UTF-8";
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
}
