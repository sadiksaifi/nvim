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

Blazingly Fast PDE for Web Development using Neovim designed for web developers.

<div id="gif-container" style="display: flex; justify-content: center; align-items: center;">
  <img src="https://data.sadiksaifi.dev/Screenshots/Neovim.gif" loop autoplay>
</div>

## Install [Neovim 0.11](https://github.com/neovim/neovim/releases/tag/v0.11.4)

### Mac
```sh
brew install neovim
```

### Linux

| Distribution | Command |
| ------------ | ------- |
| Arch Linux | `sudo pacman -S neovim` |
| Fedora | `sudo dnf install neovim` |
| Debian/Ubuntu | Neovim's 0.10 may not be available in Debian/Ubuntu's package repositories. You can install it from the [official repository](https://github.com/neovim/neovim/releases/tag/v0.10.0). |

### Windows
Install WSL2(Windows Subsystem for Linux) and follow the Linux instructions.

## Required Dependencies
- node >= 20.x
- npm >= 10.x
- gcc/clang
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [Nerd Fonts](https://www.nerdfonts.com/) - An easy tool to install ([getnf](https://github.com/ronniedroid/getnf))

## Install the config

Make sure to remove or move your current `nvim` config directory.

```sh
mv ~/.config/nvim/ ~/.config/nvim-bak/
git clone https://github.com/sadiksaifi/nvim.git ~/.config/nvim
```
> Run `nvim` and wait for the plugins to be installed

## Structure
`~/.config/nvim`

```sh
nvim
├── after
│   ├── ftplugin
│   │   └── json.lua
│   └── queries
│       └── markdown
│           └── injections.scm
├── ftdetect
│   ├── astro.lua
│   └── mdx.lua
├── init.lua
├── lazy-lock.json
├── lua
│   ├── plugins
│   │   ├── ai.lua
│   │   ├── cmp.lua
│   │   ├── colorscheme.lua
│   │   ├── comment.lua
│   │   ├── lsp.lua
│   │   ├── luasnip.lua
│   │   ├── neogit.lua
│   │   ├── none-ls.lua
│   │   ├── telescope.lua
│   │   ├── treesitter.lua
│   │   └── typescript.lua
│   └── user
│       ├── autocmds.lua
│       ├── keymaps.lua
│       ├── languages.lua
│       ├── lazy-setup.lua
│       ├── options.lua
│       └── ui.lua
├── plugin
│   ├── colorscheme.lua
│   ├── netrw.lua
│   └── statusline.lua
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
