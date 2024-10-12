{ bit32, buildLuarocksPackage, compat53, fetchFromGitHub, fetchurl, hump, lua-term, luaOlder, wcwidth }:
buildLuarocksPackage {
  pname = "sirocco";
  version = "0.0.1-5";
  knownRockspec = (fetchurl {
    url    = "mirror://luarocks/sirocco-0.0.1-5.rockspec";
    sha256 = "0bs2zcy8sng4x16clfz47cn4l6fw43rj224vjgmnkfvp9nznd4b4";
  }).outPath;

  # src = builtins.fetchGit {
  #   url = "https://github.com/giann/sirocco";
  #   #owner = "giann";
  #   #repo = "sirocco";
  #   rev = "b2af2d336e808e763b424d2ea42e6a2c2b4aa24d";
  #   #hash = "sha256-pWZV9l+n1/5AvpCPxNYPbJBHyI04YDolnUu+hYen8TA=";
  #   submodules = true;
  # };

  src = fetchFromGitHub {
    #url = "https://github.com/giann/sirocco";
    owner = "giann";
    repo = "sirocco";
    rev = "b2af2d336e808e763b424d2ea42e6a2c2b4aa24d";
    hash = "sha256-LcdHV+STHNZzRaw/aoIWi71Gx1t4+7uHVoP9w6Rrc9Y=";
    #hash = "sha256-pWZV9l+n1/5AvpCPxNYPbJBHyI04YDolnUu+hYen8TA=";
    fetchSubmodules = true;
  };

  disabled = luaOlder "5.1";
  propagatedBuildInputs = [ bit32 compat53 hump lua-term wcwidth ];

  meta = {
    homepage = "https://github.com/giann/sirocco";
    description = "A collection of useful cli prompts";
    license.fullName = "MIT/X11";
  };
}
