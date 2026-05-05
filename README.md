# NixOS configuration

To rebuild the system use

```bash
$ rebuild.sh
```

Use `-h` for help with the options of running the rebuild script.

The design is modular: This means that you can create a new host in the directory "hosts", and then use the rebuild script `rebuild.sh`, with the host name as the target of the rebuild, to create a new machine. The modules can easily be enabled or disabled:

```nix
# nixos/hosts/"machine"
ghostty.enable = true;
```

This enables the module for the ghostty terminal.

Do not use the hardware configurations from this repository as they are likely not compatible with other systems. To generate a new hardware configuration use `nixos-generate-config`

## Further work

- dendritic pattern (big task)

### Modules to add

- comma (for testing packages)
- nix-index (for finding packages that own file)
- nurl, nix-init (for flake generation)
- statix (linter for nix)
- nix-direnv (improved direnv)
- hjem (improved home manager)
