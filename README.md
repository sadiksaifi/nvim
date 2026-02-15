<div align="center">

# ~/.config/nvim

**Blazingly fast personal development environment.**

[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat&logo=lua&logoColor=white)](https://www.lua.org/)
[![Neovim](https://img.shields.io/badge/Neovim-57A143?style=flat&logo=neovim&logoColor=white)](https://github.com/neovim/neovim)
[![Catppuccin](https://img.shields.io/badge/Catppuccin-Macchiato-cba6f7?style=flat)](https://github.com/catppuccin/nvim)

<br>

<img src="https://data.sadiksaifi.dev/Screenshots/Neovim.gif" width="800">

</div>

---

## Install

```sh
mv ~/.config/nvim/ ~/.config/nvim-bak/
git clone https://github.com/sadiksaifi/nvim.git ~/.config/nvim
```

> Run `nvim` and wait for the plugins to be installed.

## Structure

```
~/.config/nvim
├── init.lua              -- Entry point, loads lua/user/
├── lua/
│   ├── user/             -- Core config (options, keymaps, lazy.nvim bootstrap, diagnostics)
│   └── plugins/          -- Plugin specs loaded by lazy.nvim
├── after/
│   ├── ftdetect/         -- Custom filetype detection (astro, mdx)
│   └── queries/          -- Custom treesitter queries
└── lazy-lock.json        -- Plugin lockfile
```

## Acknowledgements

- [ChristianChiarulli](https://github.com/ChristianChiarulli)
- [Nvim Basic Ide](https://github.com/lunarvim/nvim-basic-ide)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Lsp Zero](https://github.com/VonHeikemen/lsp-zero.nvim)
