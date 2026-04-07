{pkgs}:
pkgs.buildGoApplication rec {
  pname = "terramaid";
  version = "2.6.2";
  src = ./.;

  subPackages = ["."];

  ldflags = ["-s" "-w" "-X=cmd.Version=${version}"];

  go = pkgs.go-bin.latest;
  modules = ./govendor.toml;

  meta = with pkgs.lib; {
    description = "A utility for generating Mermaid diagrams from Terraform configurations";
    homepage = "https://github.com/RoseSecurity/Terramaid";
  };
}
