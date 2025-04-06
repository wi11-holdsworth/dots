{ config, lib, ... }:
let
  feature = "speakers";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
    boot.extraModprobeConfig = ''
      options snd_hda_intel power_save=0
    '';
  };
}
