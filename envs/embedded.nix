{ mkShell, nrfutil, nrf-command-line-tools, ... }: mkShell {
  name = "embedded";
  packages = [ nrfutil nrf-command-line-tools ];
}
