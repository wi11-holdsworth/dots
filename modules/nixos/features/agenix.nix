{
  config,
  inputs,
  lib,
  system,
  userName,
  ...
}:
let
  feature = "agenix";
in
{
  config = lib.mkIf config.${feature}.enable {
    age.identityPaths = [ "/home/${userName}/.ssh/id_ed25519" ];
    environment.systemPackages = [ inputs.agenix.packages.${system}.default ];
  };

  imports = [ inputs.agenix.nixosModules.default ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
