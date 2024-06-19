{ mkShell
, nrf-command-line-tools
, cmake
, ninja
, python3
, dtc
, openocd
, zephyr
}: mkShell {
  name = "embedded";
  packages = [
    openocd
    nrf-command-line-tools
    (python3.withPackages (pkgs: with pkgs;[ west ]))
    (zephyr.sdk.override {
      targets = [
        "x86_64-zephyr-elf"
        "arm-zephyr-eabi"
      ];
    })
    dtc
  ];
  nativeBuildInputs = [ cmake ninja ];

  shellHook = ''
    # Setup the virtual environment if it doesn't already exist.
    VENV=.venv
    if test ! -d $VENV; then
      python -m venv $VENV
    fi
    source ./$VENV/bin/activate
  '';
}
