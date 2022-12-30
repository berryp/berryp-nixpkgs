{
  stdenv,
  fetchurl,
  xar,
  cpio,
  pkgs,
  unzip,
  pbzx,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "lg-osc";
  version = "5.65";

  src = fetchurl {
    url = "https://gscs-b2c.lge.com/downloadFile?fileId=j5MCgvPixs3AdnUEmllYpg";
    sha256 = "sha256-ttn4bNcVSz6PqMRPfNvEHANYXMXo1Fjhtepz7RwimX8=";
  };

  nativeBuildInputs = [unzip xar cpio];

  outputs = ["out"];

  unpackPhase = ''
    unzip $src
    xar -xf OSC_V${version}_signed.pkg
  '';

  installPhase = ''
    start="$(pwd)"
    mkdir -p $out

    packages=($(cat Distribution | grep -oP "(?<=>#)[^<]*"))

    for pkg in "''${packages[@]}"; do
      cd "$start/$pkg"
      install_location=$out$(cat PackageInfo | grep -oP "(?<=install-location\=\")[^\"]*")
      mkdir -p $install_location
      zcat Payload | cpio -idm
      rm Bom Payload PackageInfo
      if [[ -f "Scripts" ]]; then
        zcat Scripts | cpio -idm
        rm Scripts
      fi
      mv * $install_location
    done
  '';

  meta = with lib; {
    description = "LG OnScreenControl";
    maintainers = with maintainers; [berryp];
    platforms = platforms.darwin;
  };
}
