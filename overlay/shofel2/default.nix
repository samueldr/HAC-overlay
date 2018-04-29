{ stdenv
, fetchFromGitHub
# For the payload.
, gcc-arm-embedded
# For the tethered app.
, python3
, python3Packages
}:

let
  src = stdenv.mkDerivation {
    name = "shofel2-src";
    src = fetchFromGitHub {
      owner = "fail0verflow";
      repo = "shofel2";
      rev = "0dfe73c43d62da06a176a5b125c02417aae95bf8";
      sha256 = "0203vi82vh8ssffv5j0sxa6nkmm904iml5qh69cccim9g8vbm88y";
    };
    dontBuild = true;
    installPhase = ''
      mv exploit $out
    '';
  };
in

stdenv.mkDerivation rec {
  inherit src;
  name = "shofel2";
  version = "0.0.0.20180425";

  TOOLCHAIN = "arm-none-eabi-";

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
    cp ${./shofel2} $out/bin/shofel2
    chmod +x $out/bin/*
    substituteInPlace $out/bin/shofel2 \
      --replace '@OUT@' "$out"
    wrapPythonProgramsIn "$out/misc" "$out $pythonPath"
  '';
  fixupPhase = ''
    echo "done!"
  '';
}
