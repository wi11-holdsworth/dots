{ config, lib, ... }:
let
  feature = "nh";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  # TODO: remove reference to username
  config = lib.mkIf cfg.enable {
    programs.${feature} = {
      enable = true;
      clean.enable = true;
      flake = "/home/will/.dots";
    };
  };
}
