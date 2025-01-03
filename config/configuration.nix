{ ... }:
{
  imports = [
    ./audio
    ./hardware-configuration.nix
    ./machine
    ./misc
  ];

  system.stateVersion = "24.05";

}
