.SUFFIXES:
.SUFFIXES: .sh


.sh:
	sh $< > $@


default: configuration.nix


json: clean configuration.json


configuration.json: configuration.nix
	NIXPKGS_ALLOW_UNFREE=1 nix-instantiate --strict --json --show-trace --eval -E \
		"import ./$< { config = {}; pkgs = import <nixpkgs> {}; lib = import <nixpkgs/lib>; }" \
		> $@

clean:
	rm -rfv configuration.{nix,json}

