# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration built on top of **AstroNvim v5+**, a feature-rich Neovim configuration framework. The configuration supports multiple languages including Ruby, Python, Rust, Go, Lua, Bash, Docker, and Markdown through LSP servers managed by Mason.

### Key Plugins

- **nvim-surround**: Add/delete/change surrounding delimiters (parentheses, quotes, tags, etc.)

## Architecture

### Bootstrap and Plugin Management

- **init.lua**: Entry point that bootstraps Lazy.nvim plugin manager and loads the main configuration
- **lua/lazy_setup.lua**: Configures Lazy.nvim and imports plugin specs from three locations:
  1. AstroNvim core plugins (`astronvim.plugins`)
  2. Community plugins (`community.lua`)
  3. Custom plugins (`plugins/` directory)
- **lua/polish.lua**: Final customization file for pure Lua code that doesn't fit elsewhere

### Configuration Structure

Plugin configurations are organized in `lua/plugins/` with each file returning a LazySpec table:

- **astrocore.lua**: Core AstroNvim features, vim options, keybindings, autocommands, and diagnostics
- **astrolsp.lua**: LSP configuration including server setup, formatting options, and LSP-specific keybindings
- **astroui.lua**: UI customizations and theming
- **mason.lua**: LSP server, formatter, and linter installation via Mason
- **toggleterm.lua**: Terminal integration with custom terminal instances
- **treesitter.lua**: Treesitter parser configuration
- **none-ls.lua**: null-ls sources for additional formatting/linting
- **user.lua**: Additional custom plugin configurations

### Guard Clauses

Several configuration files have guard clauses (`if true then return {} end` or `if true then return end`) at the top, making them inactive by default:
- `lua/community.lua`
- `lua/plugins/astrocore.lua` - **Contains important settings like wrap=true**
- `lua/plugins/user.lua`
- `lua/polish.lua`

**To activate these files, remove the guard clause line.**

Note: The following files are now active (guard clauses removed):
- `lua/plugins/none-ls.lua` - Ruby formatting with Rubocop
- `lua/plugins/treesitter.lua` - Syntax highlighting for multiple languages

## Ruby Development Setup

This configuration uses a **mise-managed ruby-lsp installation** instead of Mason-installed ruby-lsp:

- Ruby LSP is enabled in `lua/plugins/astrolsp.lua` servers list
- Mason is configured to **exclude ruby_lsp** from automatic installation (`lua/plugins/mason.lua`)
- Rubocop LSP is **disabled** (ruby-lsp handles linting natively)
- Ruby LSP Rails addon is enabled with pending migrations prompts

### Ruby Formatting with Rubocop

Ruby files are auto-formatted on save using `bundle exec rubocop -a` via none-ls:

- Configured in `lua/plugins/none-ls.lua`
- Uses **local project's rubocop** via `bundle exec` (respects project's Gemfile)
- Only runs in projects that have a `Gemfile` present
- Auto-formatting on save is enabled globally in `lua/plugins/astrolsp.lua`

## Formatting Configuration

Auto-formatting on save is enabled for multiple file types via none-ls (`lua/plugins/none-ls.lua`):

- **Ruby**: `bundle exec rubocop -a` (only in projects with Gemfile)
- **Markdown**: Prettier (also handles JSON, YAML, TOML)

Prettier is installed via Mason and provides consistent formatting for documentation and configuration files.

## Terminal Integration (Toggleterm)

Custom terminal instances are configured in `lua/plugins/toggleterm.lua`:

- **Lazygit**: Full-screen git TUI (accessed via `<leader>gg`)
- **Python REPL**: Floating Python interactive shell (accessed via `<leader>tp`)
- **Node REPL**: Floating Node.js interactive shell (accessed via `<leader>tn`)
- **Htop**: System monitor (accessed via `<leader>tH`)

Each terminal is configured as a separate Terminal instance with custom `on_open` and `on_close` callbacks.

### Terminal Appearance

Floating terminals are configured with:
- Curved borders for a clean aesthetic
- `winblend = 20` (80% opaque, 20% transparent) for a modern look while maintaining readability
- 80% of screen width and height by default

**Note on blur effects**: Neovim's `winblend` provides transparency but not blur. For background blur effects, you'll need to configure your terminal emulator to enable blur, which will then apply to the transparent areas of Neovim windows.

Terminal emulator blur configuration:
- **Ghostty**: Add `background-blur-radius = 20` to your Ghostty config
- **Kitty**: Set `background_blur 20` in `kitty.conf`
- **iTerm2**: Enable blur in Preferences → Profiles → Window → Blur
- **WezTerm**: Set `config.macos_window_background_blur = 20`
- **Alacritty**: Requires compositor support (like picom on Linux)

## Key Configuration Patterns

### Adding New Plugins

Add new plugin specs to `lua/plugins/user.lua` (after removing the guard clause). Follow the LazySpec format:

```lua
return {
  "author/plugin-name",
  opts = { ... },
  config = function(plugin, opts)
    -- setup code
  end,
  keys = { ... },
}
```

### Configuring LSP Servers

1. Add server name to `servers` list in `lua/plugins/astrolsp.lua`
2. Add custom configuration to `config` table if needed
3. Use `handlers` to disable or customize server setup
4. For Mason-installed servers, add to `ensure_installed` in `lua/plugins/mason.lua`

### Vim Options

Set vim options in `lua/plugins/astrocore.lua` under `opts.options.opt` (for `vim.opt.*`) or `opts.options.g` (for `vim.g.*`).

### Custom Keybindings

Define keybindings in `lua/plugins/astrocore.lua` under `opts.mappings`, organized by mode (`n`, `v`, `i`, etc.).

### Surround Operations (nvim-surround)

The nvim-surround plugin provides text object manipulation:
- `ys{motion}{char}` - Add surrounding (e.g., `ysw(` surrounds word with parentheses)
- `ds{char}` - Delete surrounding (e.g., `ds(` deletes surrounding parentheses)
- `cs{old}{new}` - Change surrounding (e.g., `cs([` changes `()` to `[]`)
- Visual mode: `S{char}` - Surround selection (e.g., select text then `S(`)

Common examples:
- `ysiw"` - Surround inner word with double quotes
- `yss)` - Surround entire line with parentheses
- `ds"` - Delete surrounding double quotes
- `cs'"` - Change single quotes to double quotes

## Configured Language Servers

The following LSP servers are automatically installed via Mason (configured in `lua/plugins/mason.lua`):

- **Lua**: `lua-language-server` (lua_ls)
- **Python**: `pyright`
- **Rust**: `rust-analyzer`
- **Go**: `gopls`
- **Bash**: `bash-language-server` (bashls)
- **Docker**: `dockerfile-language-server` (dockerls)
- **Markdown**: `marksman`
- **Ruby**: `ruby_lsp` (managed via mise, excluded from Mason)

Note: Fish shell does not have a widely-used LSP server available.

## Treesitter Configuration

Treesitter is configured in `lua/plugins/treesitter.lua` to provide syntax highlighting for multiple languages:

- **Core**: Lua, Vim, Vimdoc
- **Programming Languages**: Python, Rust, Go, Ruby, Bash, Fish
- **Markup**: Markdown, Markdown inline (for code blocks in markdown)
- **Config Formats**: JSON, YAML, TOML, Dockerfile

The `markdown_inline` parser enables syntax highlighting for code blocks within markdown files, allowing you to see proper syntax highlighting for Python, Ruby, Rust, etc. snippets in your documentation.

## Development Commands

### Neovim Commands

- `:AstroUpdate` - Update AstroNvim and all plugins
- `:Lazy` - Open Lazy.nvim plugin manager UI
- `:Mason` - Open Mason tool installer UI
- `:LspInstall <server>` - Install an LSP server
- `:LspInfo` - Show attached LSP servers for current buffer
- `:checkhealth` - Check Neovim and plugin health

### Prerequisites

Ensure these are installed on your system:
- Neovim >= 0.9.5
- Git
- ripgrep (for Telescope)
- Node.js (for some LSP servers)
- Python 3 (for Python LSP and some plugins)
- Rust toolchain (for rust-analyzer)
- Go toolchain (for gopls)
- Optional: lazygit, Nerd Font

Note: Most LSP servers will be automatically installed by Mason, but they may require their respective language toolchains to function properly.

## Important Notes

- Leader key is `<Space>` (configured in `lua/lazy_setup.lua:7`)
- Local leader key is `,` (configured in `lua/lazy_setup.lua:8`)
- Format on save is **enabled by default** for all filetypes (configurable in `lua/plugins/astrolsp.lua`)
- The configuration disables several default vim plugins for performance (gzip, netrw, tar, tohtml, zip)
