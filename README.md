# neovim

My neovim config.

## Install

Clone the repository

```sh
git clone https//github.com/krhubert/nvim ~/.config/nvim
```

Make sure you have all deps for setup nvim:

```sh
make check
```

Install external dependencies and configs:

```sh
make install
make config
```

Start neovim and let lazyvim install plugins:

```sh
nvim
```

Restart neovim check the health status:

```neovim
:checkhealth
```
