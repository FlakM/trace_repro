# trace_repro

## Nix installation

Install according to: https://nixos.org/download

```bash
# install nix - package manager
sh <(curl -L https://nixos.org/nix/install) --daemon

# enable nix flakes
mkdir -p "$HOME/.config/nix"
echo 'experimental-features = nix-command flakes' > "$HOME/.config/nix/nix.conf"
```

## Running a VM

```bash
QEMU_NET_OPTS="hostfwd=tcp::2221-:22" nix run .#nixosConfigurations.test.config.system.build.vm
```

## SSH into the machine

```bash
ssh -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i private_key.pem root@localhost -p 2221
```

## Bug(?) reproduce steps

1. Launch a vm
2. Open two ssh sessions (`A` and `B`)
3. In `A` run: `bpftrace $(which gethostlatency.bt) -p $$`
4. In `B` run:  `curl https://google.com`

Expected behavior: terminal A shows no entries
Actual behavior: terminal A contains logged queries 
