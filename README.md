# purpose

devcontainer setup to build EVM and Solana smart contract + TS/Python stuff on Linux

the point of this container is not to provide reproducible builds or security guarantees by nailing down versions but to serve as a recipe to easily build an up to date devbox (hence the name) for developing stuff

the intended use is to build the container once and then reference the image, to avoid constant rebuilding and disk clutter (see `mkcont` bashrc alias)


# install

## prereqs

install prereqs by following e.g. [the tutorial](https://code.visualstudio.com/docs/devcontainers/tutorial)


## devcontainer cli

install [devcontainer cli](https://github.com/devcontainers/cli):
`npm install -g @devcontainers/cli`


## pnpm store

the default Linux path of pnpm store of the container (`.local/share/pnpm/store`) is mapped to `~/dev/pnpm-store` on the host to allow sharing of `node_modules` to save disk space - adjust or delete `mount` property in `devcontainer.json` as necessary

**WARNING: the build will fail if the host mount does not exist!**


## build

create a symlink (because the devcontainer cli is not very bright and always looks for a .devcontainer folder when building local features):

`ln -s devcontainer .devcontainer`

create the shared pnpm store mount dir (if used - see above):

`mkdir -p ~/dev/pnpm-store`

then build:

`devcontainer build --workspace-folder . --image-name devbox`

to update an existing devbox, add `--no-cache`: `latest` is resolved only when a feature's layer is built, so a cached layer keeps whatever version was current back then


# hardware wallets

sign and send txs with a Ledger or Trezor from inside the container (e.g. `cast send --ledger ...`).

prerequisite: the wallet already works on the *host* - on Linux that means the vendor udev rules are installed ([Ledger](https://github.com/LedgerHQ/udev-rules), [Trezor](https://trezor.io/guides/trezorctl/udev-rules)).

## container access

`mkcont` injects two `runArgs`:

* `--volume=/dev/bus/usb:/dev/bus/usb` mounts the usb *directory* rather than a fixed `--device` node, so a wallet that is replugged or re-enumerated (a Ledger re-enumerates when unlocked) shows up live without restarting the container
* `--device-cgroup-rule=c 189:* rmw` lifts Docker's default-deny on device access for all usb (major 189)

## verify

plug in and unlock the device, then from inside the container: `cast wallet address --ledger` (or `--trezor`).


# usage

## bashrc alias

add convenience alias for creating reference containers to `.bashrc`:

`alias mkcont='mkdir -p .devcontainer && echo "{ \"image\": \"devbox\", \"remoteUser\": \"vscode\", \"initializeCommand\": \"sleep 3\", \"runArgs\": [\"--device-cgroup-rule=c 189:* rmw\", \"--volume=/dev/bus/usb:/dev/bus/usb\"] }" > .devcontainer/devcontainer.json'`

`initializeCommand` runs on the *host*, before the container is created, and the tooling blocks on it. the `sleep 3` works around an intermittent "terminal stuck at startup" race (most likely the recreate racing the previous container's teardown) - it is not always needed, so drop it if you never hit the hang.

the `runArgs` grant hardware-wallet access (Ledger/Trezor) - see [hardware wallets](#hardware-wallets). they are harmless no-ops on a non-Linux host or with no wallet attached.

## lazydocker

comfortably manage/delete containers via [lazydocker cli](https://github.com/jesseduffield/lazydocker):

`brew install jesseduffield/lazydocker/lazydocker`


# devcontainer references

* [spec](https://containers.dev/)
* [github](https://github.com/devcontainers)
* [tutorial](https://code.visualstudio.com/docs/devcontainers/tutorial)
