{ stdenv
, fetchFromGitHub
# For the payload.
, gcc-arm-embedded
# For the tethered app.
, python3
, python3Packages
}:

stdenv.mkDerivation rec {
  name = "fusee-launcher";
  version = "0.0.0.20180423";
  src = fetchFromGitHub {
    owner = "reswitched";
    repo = "fusee-launcher";
    rev = "21a30bbf419eb4edda0d372d2209e43cc7328ba6";
    sha256 = "1ayrvwyab8lky186m3zkh7xlkfzyx4x4lknm69xx04nddjxm1462";
  };

  nativeBuildInputs = [
    python3Packages.wrapPython
  ];

  buildInputs = [
    gcc-arm-embedded
    python3
  ] ++ pythonPath;

  pythonPath = with python3Packages;
  [
    wrapPython
    pyusb
    libusb1
  ];

  dontStrip = true;

  installPhase = ''
    mkdir -p $out/bin
    cp -prf . $out/misc
    cp ${./fusee-launcher} $out/bin/fusee-launcher
    chmod +x $out/bin/*
    substituteInPlace $out/bin/fusee-launcher \
      --replace '@OUT@' "$out"
    wrapPythonProgramsIn "$out/misc" "$out $pythonPath"
  '';
  fixupPhase = ''
    echo "done!"
  '';
}
