{
  stdenv,
  src
}:

stdenv.mkDerivation {
  name = "vice_standalone";
  inherit src;

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
