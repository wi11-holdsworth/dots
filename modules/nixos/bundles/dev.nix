{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # keep-sorted start
    bacon
    cargo-info
    devenv
    just
    mask
    rusty-man
    vscode
    # keep-sorted end
  ];

}
