{
  buildDotnetModule,
  dotnetCorePackages,
  makeWrapper,

  dataminer,

  src,
}:

buildDotnetModule {
  name = "pics-watcher";

  projectFile = "GameTracking.csproj";
  nugetDeps = ./pics-watcher-deps.nix;

  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;

  nativeBuildInputs = [
    makeWrapper
  ];

  postFixup = ''
    wrapProgram $out/bin/GameTracking \
      --prefix PATH : "${dataminer}/bin"
  '';

  inherit src;
}
