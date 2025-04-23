{ rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "kidex";
  version = "0.1.1";
  #cargoLock.lockFile = ./Cargo.lock;
  cargoHash = "sha256-JhGsWYUQOpPfRAjeL1NNz1B1j+jONBgynDRnvLfH7PM=";
  src = fetchFromGitHub {
    owner = "Kirottu";
    repo = "kidex";
    rev = "d1aad240eb0bac7f017183fc80b0dc41f49a98d3";
    sha256 = "146viar9qd5ap1ldiq9gm3zbh3z81gpd92hkcy6n9k2fha2kh1if";
  };
}
