-- Customize Mason

---@type LazySpec
return {
  -- use mason-lspconfig to configure Mason
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      -- Prevent Mason from auto-installing ruby-lsp (use mise version instead)
      automatic_installation = {
        exclude = { "ruby_lsp" },
      },
    },
  },
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- Language servers (LSPs)
        "lua-language-server",  -- Lua
        "pyright",              -- Python
        "rust-analyzer",        -- Rust
        "gopls",                -- Go
        "bash-language-server", -- Bash
        "dockerfile-language-server", -- Docker
        "marksman",             -- Markdown

        -- Formatters
        "stylua",               -- Lua formatter
        "prettier",             -- Markdown, JSON, YAML formatter

        -- Debuggers
        "debugpy",              -- Python debugger

        -- Other tools
        "tree-sitter-cli",
      },
    },
  },
}
