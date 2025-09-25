{
  config,
  lib,
  userName,
  ...
}:
let
  feature = "agenix";
in
{
  config = lib.mkIf config.${feature}.enable {
    age.identityPaths = [ "/home/${userName}/.ssh/id_ed25519" ];
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
