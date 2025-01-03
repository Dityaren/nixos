{ pkgs, ... }:
{
  imports = [
    ./user.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  services.cloudflare-warp.enable = false;

  fonts.packages = with pkgs; [
    font-awesome
    hack-font

  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
