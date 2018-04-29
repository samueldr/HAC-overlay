{ stdenv
, fetchFromGitHub
, pkgconfig
, libusb
}:

stdenv.mkDerivation rec {
  name = "imx-usb-loader-${version}";
  version = "0.2pre-2018-04-24";
  src = fetchFromGitHub {
    owner = "boundarydevices";
    repo = "imx_usb_loader";
    rev = "04cd5c487e0f571693ec7b23a40a5d5ad52a38f0";
    sha256 = "0kjrhp19y3g1dzk93ygajrmdby9lgi8haqbf9ghq242z5w68dxv8";
  };

  nativeBuildInputs = [
    libusb
    pkgconfig
  ];

  makeFlags = [
    "DESTDIR=$(out)"
    "prefix=/"
  ];
}
