{
  lib,
  src,
  stdenv,
  cmake,
  pkg-config,
  fmt,
  nlohmann_json,

  steam-run,
  makeWrapper
}:

stdenv.mkDerivation {
  name = "convar-dumper";
  inherit src;

  nativeBuildInputs = [
    cmake
    pkg-config
    makeWrapper
  ];
  buildInputs = [
    fmt
    nlohmann_json
  ];

  postFixup = ''
    mv $out/bin/cvdumper $out/bin/.cvdumper-wrapped
    makeWrapper ${steam-run}/bin/steam-run $out/bin/cvdumper \
      --add-flags $out/bin/.cvdumper-wrapped
  '';
}
