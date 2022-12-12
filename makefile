.SUFFIXES:
.SUFFIXES: .sh


.sh:
	sh $< > $@


default: configuration.nix configuration_git.nix


debug: clean configuration.json configuration_git.json


configuration.json: configuration.nix
	NIXPKGS_ALLOW_UNFREE=1 nix-instantiate --strict --json --eval -E \
		"import ./$< { config = {}; pkgs = import <nixpkgs> {}; lib = import <nixpkgs/lib>; modulesPath = ./.; }" \
		> $@

configuration_git.json: configuration_git.nix
	NIXPKGS_ALLOW_UNFREE=1 nix-instantiate --strict --json --eval -E \
		"import ./$< { config = {}; pkgs = import <nixpkgs> {}; lib = import <nixpkgs/lib>; modulesPath = ./.; }" \
		> $@

clean:
	rm -rfv configuration{_git,}.{nix,json}

