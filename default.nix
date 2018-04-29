with (import (fetchTarball channel:nixos-18.03)) {
  overlays = [
    (import ./overlay)
  ];
}; 

with pkgs;

stdenv.mkDerivation rec {
  name = "HAC-tools";
  buildInputs = [
    shofel2
    imx-usb-loader
    fusee-launcher
  ];
}
