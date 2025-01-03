{ ... }:
{
  imports = [
    ./network.nix
    ./bootloader.nix
    ./timezone_layout.nix
    ./greeter.nix
    ./packages.nix
    ./system_environtment.nix
  ];
}
