.SUFFIXES:
.SUFFIXES: .sh


.sh:
	sh $< > $@


default: configuration.nix


debug: clean configuration.json


configuration.json: configuration.nix
	NIXPKGS_ALLOW_UNFREE=1 nix-instantiate --strict --json --eval -E \
		"import ./$< { config = {}; pkgs = import <nixpkgs> {}; lib = import <nixpkgs/lib>; }" \
		> $@

clean:
	rm -rfv configuration.nix configuration.json

