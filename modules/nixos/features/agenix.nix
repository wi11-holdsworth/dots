{
  config,
  inputs,
  lib,
  system,
  ...
}:
let
  feature = "agenix";
in
{
  config = lib.mkIf config.${feature}.enable {
    environment.systemPackages = [ inputs.agenix.packages.${system}.default ];
  };

  imports = [ inputs.agenix.nixosModules.default ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
