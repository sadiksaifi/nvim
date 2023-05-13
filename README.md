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

<p align="center">
<img src="https://user-images.githubusercontent.com/86684667/231339807-42188b62-4c23-44fb-8a3e-6ce0eb7ac89c.png" width = 90% />
<img src="https://user-images.githubusercontent.com/86684667/231339935-206be3f3-d262-4f81-b455-60c5f4837d1d.png" width = 90% />
<img src="https://user-images.githubusercontent.com/86684667/231340028-c6261b3d-5bd6-4aed-a9d4-4784577250d8.png" width = 90% />
<p>

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

## Config dependencies
- node
- npm
- gcc

## Install the config

Make sure to remove or move your current `nvim` directory

```sh
mv ~/.config/nvim/ ~/.config/nvim-bak/
git clone https://github.com/sadikeey/nvim.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

## Structure
`~/.config/nvim`

```sh
nvim
  ├── after
  │   └── ftplugin
  │       ├── c.lua
  │       ├── cpp.lua
  │       ├── json.lua
  │       └── tex.lua
  ├── init.lua
  ├── lazy-lock.json
  ├── lua
  │   ├── core
  │   │   ├── autocommands.lua
  │   │   ├── keymaps.lua
  │   │   └── options.lua
  │   ├── lazy-setup.lua
  │   └── plugins
  │       ├── alpha.lua
  │       ├── autopairs.lua
  │       ├── bufferline.lua
  │       ├── comment.lua
  │       ├── completion.lua
  │       ├── gitsigns.lua
  │       ├── indentline.lua
  │       ├── lsp.lua
  │       ├── lualine.lua
  │       ├── null-ls.lua
  │       ├── nvimtree.lua
  │       ├── peek.lua
  │       ├── rosepine.lua
  │       ├── snippets.lua
  │       ├── telescope.lua
  │       ├── toggleterm.lua
  │       ├── treesitter.lua
  │       └── ts-autotag.lua
  └── plugin
      └── netrw.lua
```

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Arch Linux

  ```sh
  sudo pacman -Sy xsel # for X11
  sudo pacman -Sy wl-clipboard # for wayland
  ```

If you want pyton and node support you can also install respective packages.

**NOTE** make sure you have [node](https://nodejs.org/en/) and [python](https://www.python.org/) installed.


- Neovim python support

  ```sh
  pip install pynvim
  ```

- Neovim node support

  ```sh
  npm i -g neovim
  ```

We will also need `ripgrep` & `fd` for **`Telescope`** to work:

- Arch Linux
  ```sh
  sudo pacman install ripgrep fd
  ```

- Mac
  ```sh
  brew install ripgrep fd
  ```

---

## Fonts

I recommend using the following repo to get a "Nerd Font" (Font that supports icons)

[getnf](https://github.com/ronniedroid/getnf)

## Configuration

### LSP

To add a new LSP

First Enter:

```
:Mason
```

and press `i` on the Language Server you wish to install

Next you will need to add the server to this list: [servers](https://github.com/sadikeey/nvim/blob/lua/plugins/lsp.lua)

Note: Builtin LSP doesn't contain all lsps from [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md).

If you want to install any from there, for example terraform_lsp(which adds more functionality than terraformls, like complete resource listing),

1. You can add the lsp name in [mason lsp block](https://github.com/sadikeey/nvim/blob/lua/plugins/lsp.lua)

```lua
-- lua/plugins/lsp.lua
    lsp.ensure_installed({
      "lua_ls",
      "cssls",
      "html",
      "tsserver",
      "bashls",
      "jsonls",
      "tailwindcss",
    })
```

2. Manually install the binary of the lsp and put it in your path by downloading the binary or through your package manager. For terraform_lsp [example](https://github.com/juliosueiras/terraform-lsp/releases)


### Formatters and linters

Make sure the formatter or linter is installed and add it to this setup function: [null-ls](https://github.com/sadikeey/nvim/blob/lua/plugins/null-ls.lua)

1. You can add the lsp name in [null-ls block](https://github.com/sadikeey/nvim/blob/lua/plugins/null-ls.lua)

```lua
-- lua/plugins/null-ls.lua
  ensure_installed = {
    "prettier",
    "stylua",
    "eslint_d",
  },
```

**NOTE** Some are already setup as examples, remove them if you want

### Installing Plugins

You can install new plugins by creating a file in `~/.config/nvim/lua/plugins` directory.

Then return a lua table from that file for more info check out [lazy.nvim](https://github.com/folke/lazy.nvim).

e.g.:
```lua
return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  config = function()
    require("rosepine").setup({})

  -- Set colorscheme after options
    vim.cmd.colorscheme("rose-pine")
  end,
}
```

## Acknowledgement
- [ChristianChiarulli](https://github.com/ChristianChiarulli)
- [Nvim Basic Ide](https://github.com/lunarvim/nvim-basic-ide)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Lsp Zero](https://github.com/VonHeikemen/lsp-zero.nvim)
