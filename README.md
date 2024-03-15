<h1 align="center">Neovim IDE<br> For Web Development
<br>
<a href="https://www.lua.org/">
<img
    alt="Lua"
    src="https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white">
</a>
<a href="https://github.com/neovim/neovim">
<img
    alt="Neovim"
    src="https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white">
</a>
</h1>

## About

Blazingly Fast IDE for Web Development using Neovim is a powerful and efficient integrated development environment designed for web developers.

<div id="gif-container" style="display: flex; justify-content: center; align-items: center;">
  <img src="https://data.sadiksaifi.dev/Screenshots/Neovim.gif" loop autoplay>
</div>

## Setup

### Install [Neovim 0.9](https://github.com/neovim/neovim/releases/tag/v0.9.0)

You can install Neovim with your package manager e.g. `pacman`, `brew`, `apt`, etc.. but remember that when you update your packages Neovim may be upgraded to a newer version.

If you would like to make sure Neovim only updates when you want it to than I recommend **installing from source**:

**NOTE** Verify the required [build prerequisites](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites) for your system.

```sh
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout release-0.9
make CMAKE_BUILD_TYPE=Release
sudo make install
```

## Config Dependencies
- node >= 18
- npm >= 9
- gcc
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [Nerd Fonts](https://www.nerdfonts.com/) - An easy tool to install ([getnf](https://github.com/ronniedroid/getnf))

## Install the config

Make sure to remove or move your current `nvim` directory

```sh
mv ~/.config/nvim/ ~/.config/nvim-bak/
git clone https://github.com/sadiksaifi/nvim.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

## Structure
`~/.config/nvim`

```sh
nvim
├── after
│   └── ftplugin
│       └── json.lua
├── init.lua
├── lazy-lock.json
├── lua
│   ├── plugins
│   │   ├── cmp.lua
│   │   ├── colorizer.lua
│   │   ├── colorscheme.lua
│   │   ├── comment.lua
│   │   ├── copilot.lua
│   │   ├── devicons.lua
│   │   ├── harpoon.lua
│   │   ├── lspconfig.lua
│   │   ├── luasnip.lua
│   │   ├── mason.lua
│   │   ├── neogit.lua
│   │   ├── none-ls.lua
│   │   ├── nvimtree.lua
│   │   ├── schemastore.lua
│   │   ├── telescope.lua
│   │   ├── treesitter.lua
│   │   └── typescript.lua
│   └── user
│       ├── autocmds.lua
│       ├── icons.lua
│       ├── keymaps.lua
│       ├── lazy-setup.lua
│       ├── lspsettings
│       │   ├── jsonls.lua
│       │   └── lua_ls.lua
│       └── options.lua
├── plugin
│   └── netrw.lua
├── README.md
└── snippets
    ├── package.json
    ├── typescript.json
    └── typescriptreact.json
```

## Acknowledgement
- [ChristianChiarulli](https://github.com/ChristianChiarulli)
- [Nvim Basic Ide](https://github.com/lunarvim/nvim-basic-ide)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Lsp Zero](https://github.com/VonHeikemen/lsp-zero.nvim)
