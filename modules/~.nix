{ config, lib }:
let
  feature = "feature";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {

  };
}
