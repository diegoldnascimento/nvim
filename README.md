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

- Neovim 0.11.0+

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
- [mini.icons](https://github.com/echasnovski/mini.icons) - General icons as part of the Mini.library
- [lualine.nvim](https://github.com/shadmansaleh/lualine.nvim) - A blazing fast and easy to configure Neovim statusline written in Lua.
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - A snazzy 💅 buffer line (with tabpage integration) for Neovim built using lua.
- [colorizer.lua](nvchad/nvim-colorizer.lua) - A high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit.
- [vim-illuminate](https://github.com/RRethy/vim-illuminate) - Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
- [noice.vim](https://github.com/folke/noice.nvim) - Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
- [nvim-notify](https://github.com/rcarriga/nvim-notify) - A fancy, configurable, notification manager for NeoVim
- [better-escape.nvim](https://github.com/max397574/better-escape.nvim) - This plugin is the lua version of better_escape.vim, with some additional features and optimizations A lot of people have mappings like jk or jj to escape insert mode
- [nvim-bufedel.nvim](https://github.com/ojroques/nvim-bufdel) - A small Neovim plugin to improve the deletion of buffers.
- [vim-visual-multi](https://github.com/mg979/vim-visual-multi) - It's called vim-visual-multi in analogy with visual-block, but the plugin works mostly from normal mode.
- [onsails/lspkind.nvim](https://github.com/onsails/lspkind.nvim) - The plugin adds vscode-like icons to Neovim LSP
- [gbprod/yanky.nvim](https://github.com/gbprod/yanky.nvim) - The aim of yanky.nvim is to improve yank and put functionalities for Neovim.
- [smoka7/multicursors.nvim](https://github.com/smoka7/multicursors.nvim) - The Multicursor Plugin for Neovim extends the native Neovim text editing capabilities, providing a more intuitive way to edit repetitive text with multiple selections.

### LSP

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Nvim supports the Language Server Protocol (LSP), which means it acts as a client to LSP servers and includes a Lua framework `vim.lsp` for building enhanced LSP tools.
- [lspsaga](https://github.com/nvimdev/lspsaga.nvim?tab=readme-ov-file) - Improves the Neovim built-in LSP experience.
- [outline.nvim](https://github.com/hedyhli/outline.nvim) - A sidebar with a tree-like outline of symbols from your code, powered by LSP.

## Search & Replace

- [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) - Find And Replace plugin for neovim

### Programming Language

- [typescript-tools.nvim](https://github.com/pmizio/typescript-tools.nvim) - Blazingly fast, thanks to the utilization of the native TS_LS communication protocol, similar to Visual Studio Code.

### Mason

- [mason.nvim](https://github.com/williamboman/mason.nvim) - Easy install LSP servers, Formatters, linters and more
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Easy management for LSP servers
- [mason-null-ls.nvim](https://github.com/jay-babu/mason-null-ls.nvim) - mason-null-ls bridges mason.nvim with the null-ls plugin - making it easier to use both plugins together.
- [mason-nvim-dap](https://github.com/jayp0521/mason-nvim-dap.nvim) - Plugin for installing DAPs using Mason

### Linter

- [nvim-lint](https://github.com/mfussenegger/nvim-lint) - An asynchronous linter plugin for Neovim (>= 0.6.0) complementary to the built-in Language Server Protocol support

### Formatter

- [conform.nvim](https://github.com/stevearc/conform.nvim) - Lightweight yet powerful formatter plugin for Neovim

### Git

- [lazygit](https://github.com/kdheepak/lazygit.nvim) - Plugin for calling lazygit within NeoVIM.
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Show git signs in buffer
- [blamer.nvim](https://github.com/APZelos/blamer.nvim) - A git blame plugin for neovim inspired by VS Code's GitLans plugin.

### Debug

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
- [cmp-nvim-lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help) - nvim-cmp source for displaying function signatures with the current parameter emphasized:
- [cmp-emoji](https://github.com/hrsh7th/cmp-emoji) - nvim-emoji source for displaying emoji with the current parameter emphasized:

### Code Tests

- [neotest](https://github.com/nvim-neotest/neotest) - An extensible framework for interacting with tests within NeoVim.
- [neotest-go](https://github.com/nvim-neotest/neotest-go) - An plugin that provides a Go(lang) adapter for the Neotest framework
- [neotest-jest](https://github.com/haydenmeade/neotest-jest) - An plugin that provides a Jest adapter for the Neotest framework
- [neotest-vitest](https://github.com/marilari88/neotest-vitest) - An plugin that provides a Vitest adapter for the Neotest framework

### Fzf-Lua

- [fzf-lua](https://github.com/ibhagwan/fzf-lua/) - fzf is described as a general-purpose command line fuzzy finder meaning you can search any output using the fuzzy search algorithm. This opaque description hides an endless wealth of functionality from searching files, processes, command-line history and much more. fzf-lua aims to bring all this goodness to neovim.

### Search and Replace

- [nvim-spectre](https://github.com/nvim-pack/nvim-spectre) - A search panel for neovim.

### Mini

- [mini.indentscope](https://github.com/echasnovski/mini.indentscope) - Visualize scope with animated vertical line. It is very fast and done automatically in a non-blocking way (other operations can be performed, like moving cursor). You can customize debounce delay and animation rule.
- [mini.bracketed](https://github.com/echasnovski/mini.bracketed) - Add bracket-style navigation through various text objects including buffers, comments, diagnostics, files, indent levels, jumps, locations, quickfix entries, tree-sitter nodes, undo states, and more. Each target has multiple mapping variants for enhanced navigation.

### File Explorer

- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - Neo-tree is a Neovim plugin to browse the file system and other tree like structures in whatever style suits you, including sidebars, floating windows, netrw split style, or all of them at once

### AI

- [avante.nvim](https://github.com/yetone/avante.nvim) - Modern AI-powered coding assistant with Cursor-like functionality for Neovim. Features include real-time code editing, intelligent suggestions, comprehensive chat interface, code review, security audits, test generation, refactoring assistance, and extensive prompt library. Supports multiple LLM providers including Claude, with advanced diff handling and project-specific context via instructions files.
- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) - Enhanced markdown rendering for Neovim with support for syntax highlighting, better formatting, and improved readability. Works seamlessly with AI chat interfaces.

### Others

- [Comment](https://github.com/numToStr/Comment.nvim) - Shortcut for commenting in and out code snippets
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Used on syntax highlight and custom motions
- [rainbow-delimiters](https://gitlab.com/HiPhish/rainbow-delimiters.nvim) - This Neovim plugin provides alternating syntax highlighting (“rainbow
  parentheses”) for Neovim, powered by Tree-sitter.
- [which-key](https://github.com/folke/which-key.nvim/) - WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible key bindings of the command you started typing
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Use treesitter to autoclose and autorename HTML tag.
- [markdown-preview](https://github.com/iamcco/markdown-preview.nvim) - Preview markdown on your modern browser with synchronised scrolling and flexible configuration.
- [flash.nvim](https://github.com/folke/flash.nvim) - Flash.nvim lets you navigate your code with search labels, enhanced character motions, and Treesitter integration.
- [Todo-Comments.nvim](https://github.com/folke/todo-comments.nvim)- todo-comments is a lua plugin for Neovim >= 0.8.0 to highlight and search for todo comments like TODO, HACK, BUG in your code base.
- [kulala.nvim](https://github.com/mistweaverco/kulala.nvim) - A minimal REST-Client Interface for Neovim. Kulala is swahili for "rest" or "relax". It allows you to make HTTP requests from within Neovim.
- [vim-startuptime](https://github.com/dstein64/vim-startuptime) - vim-startuptime is a plugin for viewing vim and nvim startup event timing information. The data is automatically obtained by launching (n)vim with the --startuptime argument. See :help startuptime-configuration for details on customization options.

### Plugin development

- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Lua helpers for general usage

## Screenshots

![](https://i.postimg.cc/rFkxnq7h/2024-09-30-03-05.png)

### Get healthy

Open nvim and enter the following:

```
:checkhealth
```

### Todo


