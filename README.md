# Neovim Configuration

**NOTE:** This is for AstroNvim v5+

This is my personal Neovim configuration built on top of [AstroNvim](https://github.com/AstroNvim/AstroNvim), a feature-rich and aesthetic Neovim configuration framework.

## Prerequisites

- Neovim >= 0.9.5
- Git
- A Nerd Font (optional, but recommended for icons)
- ripgrep (for Telescope fuzzy finding)
- lazygit (optional, for git integration via toggleterm)
- Node.js (for some LSP servers)
- Python 3 (for some plugins)

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Clone the repository

```shell
git clone https://github.com/stonecharioteer/nvim-config ~/.config/nvim
```

#### Start Neovim

```shell
nvim
```

AstroNvim will automatically install all plugins on first launch. This may take a few minutes.

## ✨ Features

This configuration includes:

- **Language Server Protocol (LSP)**: Multi-language support with LSP servers for:
  - Ruby (ruby-lsp via mise)
  - Python (pyright)
  - Rust (rust-analyzer)
  - Go (gopls)
  - Lua (lua-language-server)
  - Bash (bash-language-server)
  - Docker (dockerfile-language-server)
  - Markdown (marksman)
- **Mason**: Automatic installation of LSP servers, linters, and formatters
- **Treesitter**: Syntax highlighting for multiple languages including code blocks in markdown
- **nvim-surround**: Text object manipulation for surrounding delimiters
- **Toggleterm**: Terminal integration with custom terminals for:
  - Lazygit (git TUI)
  - Python REPL
  - Node REPL
  - Htop
- **Custom keybindings**: See the plugin configurations for details

## 🔧 Key Customizations

- Ruby LSP configured to use mise-managed ruby-lsp installation
- Ruby auto-formatting with `bundle exec rubocop -a` on save
- Markdown auto-formatting with Prettier on save
- Mason configured to exclude ruby_lsp from auto-installation (uses mise version)
- Rubocop LSP disabled (ruby-lsp handles linting)
- Toggleterm with floating terminal as default
- Line wrapping enabled by default (requires activating astrocore.lua)

## 💻 Development Tools

The configuration supports multiple programming languages with automatic LSP server installation through Mason. Special configurations exist for Ruby development using mise-managed tooling.

## ⌨️ Keybindings

### Terminal (Toggleterm)

- `<C-\>`: Toggle terminal
- `<leader>tf`: Toggle floating terminal
- `<leader>th`: Toggle horizontal terminal
- `<leader>tv`: Toggle vertical terminal
- `<leader>gg`: Open Lazygit
- `<leader>tp`: Open Python REPL
- `<leader>tn`: Open Node REPL
- `<leader>tH`: Open Htop

For more keybindings, refer to the [AstroNvim documentation](https://docs.astronvim.com/).

## 🔄 Updating

To update AstroNvim and plugins:

```vim
:AstroUpdate
```

## 📝 License

This configuration is provided as-is for personal use.
