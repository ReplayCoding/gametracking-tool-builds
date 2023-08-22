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

  dotnet-sdk = dotnetCorePackages.sdk_7_0;
  dotnet-runtime = dotnetCorePackages.runtime_7_0;

  nativeBuildInputs = [
    makeWrapper
  ];

  postFixup = ''
    wrapProgram $out/bin/GameTracking \
      --prefix PATH : "${dataminer}/bin"
  '';

  inherit src;
}
