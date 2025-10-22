{
  stdenv,
  writeText,
  fetchzip,
}:
stdenv.mkDerivation {
  pname = "owntracks-frontend";
  version = "v2.15.3";
  src = fetchzip {
    url = "https://github.com/owntracks/frontend/releases/download/v2.15.3/v2.15.3-dist.zip";
    sha256 = "iy+yISPcOD/2lTyJUb1eI3wufLku1mKfVDm0+Dy8OKk=";
  };

  config = writeText "config.js" ''
    window.owntracks = window.owntracks || {};
    window.owntracks.config = {
      api: {
        baseUrl: "https://owntracks.fi33.buzz:5014"
      },
      router: {
        basePath: "owntracks"
      }
    };
  '';

  installPhase = ''
    runHook preInstall
    cp -r . $out
    cp $config $out/config/config.js
    runHook postInstall
  '';
}
