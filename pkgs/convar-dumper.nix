{
  lib,
  fetchgit,
  stdenv,
  cmake,
  pkg-config,
  lief,
  fmt,
  nlohmann_json
}:

stdenv.mkDerivation {
  name = "convar-dumper";

  src = fetchgit {
    url = "https://github.com/replaycoding/netvar-dumper";
    fetchSubmodules = true;

    # on convars branch
    rev = "28a538a251bb60e1db6a23136ab27ed253d101a2";
    sha256 = "sha256-/zGata5Ws91IcTKkiZO8jc23PRyIyIz7loRAdHZb6e4=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    lief
    fmt
    nlohmann_json
  ];
}
