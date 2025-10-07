{
  config,
  lib,
  ...
}:
let
  feature = "dev";
in
{
  config = lib.mkIf config.${feature}.enable {
    # keep-sorted start
    zed-editor.enable = lib.mkDefault true;
    # keep-sorted end
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
