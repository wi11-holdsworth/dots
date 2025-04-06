{ config, inputs, lib, ... }:
let
  feature = "vscode-server";
  cfg = config.${feature};

in {
  imports = [ inputs.${feature}.nixosModules.default ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable { services.${feature}.enable = true; };
}
