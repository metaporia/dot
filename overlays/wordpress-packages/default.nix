final: prev:
{
  wordpressPackages = builtins.fetchGit {
    url = "https://git.helsinki.tools/helsinki-systems/wp4nix";
    ref = "master";
  };

}
