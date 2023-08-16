{
  stdenv,
  lib,
  fetchFromGitHub
}:

stdenv.mkDerivation {
  name = "vice_standalone";

  src = fetchFromGitHub {
    owner = "replaycoding";
    repo = "vice_standalone";

    rev = "4d9751934594f8901f6619575655ada052009e9c";
    hash = "sha256-Yqu4Mgyj+3KF5fgbfrhNV9f3QQENzNqV3+8KU5NgXdE=";
  };

  buildPhase = ''
    # Ensure this doesn't get used
    rm bin/vice

    cd src
    make
    cd ..
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r bin/vice $out/bin/vice
  '';
}
