.SUFFIXES:
.SUFFIXES: .sh


.sh:
	sh $< > $@


default: configuration.nix configuration_debug.nix


debug: clean configuration.json configuration_debug.json


configuration.json: configuration.nix
	NIXPKGS_ALLOW_UNFREE=1 nix-instantiate --strict --json --eval -E \
		"import ./$< { config = {}; pkgs = import <nixpkgs> {}; lib = import <nixpkgs/lib>; modulesPath = ./.; }" \
		> $@

configuration_debug.json: configuration_debug.nix
	NIXPKGS_ALLOW_UNFREE=1 nix-instantiate --strict --json --eval -E \
		"import ./$< { config = {}; pkgs = import <nixpkgs> {}; lib = import <nixpkgs/lib>; modulesPath = ./.; }" \
		> $@

clean:
	rm -rfv configuration{_debug,}.{nix,json}

