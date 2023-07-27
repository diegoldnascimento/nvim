<h1 align="center">Neovim</h1>

<div align="center">
  <a href="KEYMAPS.md">Keymaps</a>
  <span> • </span>
  <a href="#install">Install</a>
  <span> • </span>
  <a href="#overview">Overview</a>
  <p></p>
</div>

<div align="center">
	
![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=for-the-badge&logo=lua)

</div>

Welcome to a personal Neovim configuration! This project aims to show everyone what a Lua configuration for Neovim looks like.
Feel free to open issues if you have suggestions or improvements. This is an ongoing project and I am constantly making
changes and experimenting new things.

# Install

**Prerequisites**

- Neovim 0.8+

Steps:

1. Clone the project in your config folder, usually `~/.config/nvim`:

```bash
git clone https://github.com/imdiegolopes/nvim  ~/.config/nvim --depth 1 && nvim
```

2. Open Neovim. You should see a _"Downloading packer.."_ and then _"plugins installed"_ message in the first run

# Overview

## Plugins

Below the list of the current plugins used in this configuration and how we are using them

### Package Manager

- [lazy.nvim]("https://github.com/folke/lazy.nvim") - lazy.nvim is a modern plugin manager for Neovim.

### Visual

- [dracula](https://github.com/Mofiqul/dracula.nvim) - Main colorscheme
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) - web devicons for general usage. Used in buffer tabs, statusline and telescope
- [lualine.nvim](https://github.com/shadmansaleh/lualine.nvim) - A blazing fast and easy to configure Neovim statusline written in Lua.
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - A snazzy 💅 buffer line (with tabpage integration) for Neovim built using lua.
- [colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) - A high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit.
- [vim-illuminate](https://github.com/RRethy/vim-illuminate) - Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
- [noice.vim](https://github.com/folke/noice.nvim) - Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
- [nvim-notify](https://github.com/rcarriga/nvim-notify) - A fancy, configurable, notification manager for NeoVim

### LSP

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Nvim supports the Language Server Protocol (LSP), which means it acts as a client to LSP servers and includes a Lua framework `vim.lsp` for building enhanced LSP tools.
- [mason.nvim](https://github.com/williamboman/mason.nvim) - Easy install LSP servers, Formatters, linters and more
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Easy management for LSP servers
- [mason-null-ls.nvim](https://github.com/jay-babu/mason-null-ls.nvim) - mason-null-ls bridges mason.nvim with the null-ls plugin - making it easier to use both plugins together.
- [formatter.nvim](https://github.com/mhartington/formatter.nvim) - We want to thank the neoformat contributors. They developed a lot of formatter configurations that we used as a reference to create our own opt-in default formatter configurations.- [lspkind.nvim](https://github.com/onsails/lspkind.nvim) - This tiny plugin adds vscode-like pictograms to neovim built-in lsp
- [nvim-lint](https://github.com/mfussenegger/nvim-lint) - An asynchronous linter plugin for Neovim (>= 0.6.0) complementary to the built-in Language Server Protocol support
- [lspkind.nvim](https://github.com/onsails/lspkind.nvim) - This tiny plugin adds vscode-like pictograms to neovim built-in lsp

### Git

- [lazygit](https://github.com/kdheepak/lazygit.nvim) - Plugin for calling lazygit within NeoVIM.
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Show git signs in buffer
- [blamer.nvim](https://github.com/APZelos/blamer.nvim) - A git blame plugin for neovim inspired by VS Code's GitLans plugin.

### Debug

- [mason-nvim-dap](https://github.com/jayp0521/mason-nvim-dap.nvim) - Plugin for installing DAPs using Mason
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) - A UI for nvim-dap which provides a good out of the box configuration.
- [nvim-dap](https://github.com/mfussenegger/nvim-dap) - nvim-dap is a Debug Adapter Protocol client implementation for Neovim.

### Snippets

- [LuaSnip](https://github.com/sar/luasnip.nvim) - Snippeter Engine for Neovim written in Lua
- [Friendly Snippets](https://github.com/rafamadriz/friendly-snippets) - Snippets collection for a set of different programming languages for faster development.

### Code Completion

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - luasnip completion source for nvim-cmp
- [nvim-path](https://github.com/hrsh7th/cmp-path) - nvim-cmp source for filesystem paths.
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - nvim-cmp source for neovim's built-in language server client.
- [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua) - nvim-cmp source for neovim Lua API.
- [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) - nvim-cmp source for vim's cmdline.
- [cmp-tabnine](https://github.com/tzachar/cmp-tabnine) - Tabnine source for hrsh7th/nvim-cmp
- [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp) - Copilot suggestions will automatically be loaded into your cmp menu as snippets and display their full contents when a copilot suggestion is hovered.

### Code Tests

- [neotest](https://github.com/nvim-neotest/neotest) - An extensible framework for interacting with tests within NeoVim.
- [neotest-go](https://github.com/nvim-neotest/neotest-go) - An plugin that provides a Go(lang) adapter for the Neotest framework
- [neotest-jest](https://github.com/haydenmeade/neotest-jest) - An plugin that provides a Jest adapter for the Neotest framework
- [neotest-vitest](https://github.com/marilari88/neotest-vitest) - An plugin that provides a Vitest adapter for the Neotest framework

### Telescope

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - telescope.nvim is a highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim core. Telescope is centered around modularity, allowing for easy customization.
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) - fzf-native is a c port of fzf. It only covers the algorithm and implements few functions to support calculating the score.
- [project.nvim](https://github.com/ahmedkhalf/project.nvim) - project.nvim is an all in one neovim plugin written in lua that provides superior project management.

### File Explorer

- [nvim-tree.nvim](https://github.com/nvim-tree/nvim-tree.lua) - Nvim-tree is a File Explorer For Neovim Written In Lua
- [oil.nvim](https://github.com/stevearc/oil.nvim) - A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.

### AI Completion

- [copilot.lua](https://github.com/zbirenbaum/copilot.lua) - GitHub Copilot is an AI pair programmer that helps you write code faster and with less work.

### Others

- [Comment](https://github.com/numToStr/Comment.nvim) - Shortcut for commenting in and out code snippets
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Used on syntax highlight and custom motions
- [which-key](https://github.com/folke/which-key.nvim/) - WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible key bindings of the command you started typing
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Use treesitter to autoclose and autorename HTML tag.
- [indent blankline](https://github.com/lukas-reineke/indent-blankline.nvim) - Adds indentation guides to all lines, including empty lines
- [markdown-preview](https://github.com/iamcco/markdown-preview.nvim) - Preview markdown on your modern browser with synchronised scrolling and flexible configuration.
- [flash.nvim](https://github.com/folke/flash.nvim)- Flash.nvim lets you navigate your code with search labels, enhanced character motions, and Treesitter integration.

### Plugin development

- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Lua helpers for general usage

## Screenshots

![](https://i.postimg.cc/BZM9b68J/Screen-Shot-2022-09-19-at-9-50-10-PM.png)

### Get healthy

Open nvim and enter the following:

```
:checkhealth
```

### Todo

- [x] Install the [nvim-dap](http://neovimcraft.com/plugin/mfussenegger/nvim-dap/index.html) which is a Debug Adapter Protocol client implementation for Nveovim, that allows to debug an application.
