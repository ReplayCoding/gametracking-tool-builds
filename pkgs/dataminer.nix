{
  lib,
  poetry2nix,
  llvmPackages,
  makeWrapper,
  vice,
  convar-dumper,
  bsp-info,

  src
}:

poetry2nix.mkPoetryApplication {
  projectDir = src;

  overrides = poetry2nix.defaultPoetryOverrides.extend (self: super: {
    bsp-tool = super.bsp-tool.overridePythonAttrs
    (
      old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ super.setuptools ];
      }
    );
  });

  nativeBuildInputs = [ makeWrapper ];

  postFixup = ''
    wrapProgram $out/bin/dataminer \
      --prefix PATH : ${lib.makeBinPath [ llvmPackages.bintools convar-dumper vice bsp-info ]}
  '';
}
