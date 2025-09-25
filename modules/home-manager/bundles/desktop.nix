{
  config,
  lib,
  ...
}:
let
  feature = "desktop";
in
{
  config = lib.mkIf config.${feature}.enable {
    # keep-sorted start
    aerc.enable = true;
    kitty.enable = true;
    mail.enable = true;
    obsidian.enable = true;
    zellij.enable = true;
    # keep-sorted end
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
