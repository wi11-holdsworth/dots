{
  config,
  inputs,
  lib,
  ...
}:
let
  feature = "vscode-server";
in
{
  config = lib.mkIf config.${feature}.enable { services.${feature}.enable = true; };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  imports = [ inputs.${feature}.nixosModules.default ];
}
