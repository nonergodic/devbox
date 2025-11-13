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


## QoL

### bashrc alias

add convenience alias for creating reference containers to `.bashrc`:

`alias mkcont='mkdir -p .devcontainer && echo "{ \"image\": \"devbox\", \"remoteUser\": \"vscode\" }" > .devcontainer/devcontainer.json'`

### lazydocker

comfortably manage/delete containers via [lazydocker cli](https://github.com/jesseduffield/lazydocker):

`brew install jesseduffield/lazydocker/lazydocker`


## devcontainer references

* [spec](https://containers.dev/)
* [github](https://github.com/devcontainers)
* [tutorial](https://code.visualstudio.com/docs/devcontainers/tutorial)
