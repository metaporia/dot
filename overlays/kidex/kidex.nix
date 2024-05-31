{ rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "kidex";
  version = "0.1";
  #cargoLock.lockFile = ./Cargo.lock;
  cargoHash = "sha256-JvVZz0+pojDhLn/3tT72g6pQdeL9tcdKv45+YBgr9AE=";
  src = fetchFromGitHub {
    owner = "Kirottu";
    repo = "kidex";
    rev = "d1aad240eb0bac7f017183fc80b0dc41f49a98d3";
    sha256 = "146viar9qd5ap1ldiq9gm3zbh3z81gpd92hkcy6n9k2fha2kh1if";
  };
}
