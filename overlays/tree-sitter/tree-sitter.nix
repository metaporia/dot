{ stdenv, tree-sitter-grammars, pkgs, coreutils }:

stdenv.mkDerivation rec {
	name = "tree-sitter-latex";
	system = builtins.currentSystem;
	unpackPhase = "true";
	installPhase = ''
		mkdir -p $out/
		cp ${tree-sitter-grammars.tree-sitter-latex}/parser $out/latex.so
		'';
}


