{
  lib,
  src,
  stdenv,
  cmake,
  pkg-config,
  lief,
  fmt,
  nlohmann_json
}:

stdenv.mkDerivation {
  name = "convar-dumper";
  inherit src;

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    fmt
    nlohmann_json
  ];
}
