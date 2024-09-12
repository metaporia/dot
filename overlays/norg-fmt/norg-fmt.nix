{ rustPlatform, fetchFromGitHub, lib }:

rustPlatform.buildRustPackage rec {
  pname = "norg-fmt";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "nvim-neorg";
    repo = "norg-fmt";
    rev = "58d8b8804a48941ed599d9236d72f0f31956b563";
    sha256 = "1a20z4hs46admjgkr98wlzzjim9kmhb2zn8m02rg0ancaipi8bqr";
  };

  #cargoHash = "sha256-GS8Ub1TMKvCyABXZLxasM9Uo/6ccpTyfrE0ZoiH5QKg=";
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "rust-norg-0.1.0" =  "sha256-SIAnp6W5O7tWBotI/jNU9mVdxmQcMTioFp5h+3E/9+Y=";
    };
  };


  #cargoDeps = rustPlatform.importCargoLock {
  #  lockFile = "${src}/Cargo.lock";
  #};

}
