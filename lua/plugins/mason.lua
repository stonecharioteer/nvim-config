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
        -- install language servers
        "lua-language-server",

        -- install formatters
        "stylua",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
