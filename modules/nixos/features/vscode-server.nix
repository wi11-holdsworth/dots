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
  config = lib.mkIf config.${feature}.enable { services.vscode-server.enable = true; };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  imports = [ inputs.vscode-server.nixosModules.default ];
}
