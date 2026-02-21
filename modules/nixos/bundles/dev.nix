{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # keep-sorted start
    bacon
    cargo-info
    mask
    # keep-sorted end
  ];
}
