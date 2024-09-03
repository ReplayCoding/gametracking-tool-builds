{
  lib,
  python3Packages,
  llvmPackages,
  makeWrapper,
  vice,
  bsp-info,

  src
}:

python3Packages.buildPythonApplication rec {
  pname = "dataminer";
  version = "0.1.0";
  inherit src;
 
  format = "pyproject";
 
  nativeBuildInputs = [ makeWrapper ];
 
   postFixup = ''
     wrapProgram $out/bin/dataminer \
       --prefix PATH : ${lib.makeBinPath [ llvmPackages.bintools vice bsp-info ]}
   '';

  pythonImportsCheck = [ "dataminer" ];
  buildInputs = [ python3Packages.setuptools ];
  propagatedBuildInputs = [ python3Packages.pyyaml ];
}
