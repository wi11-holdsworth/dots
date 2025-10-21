{
  # keep-sorted start
  inputs,
  system,
  userName,
  # keep-sorted end 
  ...
}:
{
  environment.systemPackages = [ inputs.agenix.packages.${system}.default ];
  age.identityPaths = [ "/home/${userName}/.ssh/id_ed25519" ];

  imports = [ inputs.agenix.nixosModules.default ];
}
