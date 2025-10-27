-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      -- Core
      "lua",
      "vim",
      "vimdoc",

      -- Languages
      "python",
      "rust",
      "go",
      "ruby",
      "bash",
      "fish",

      -- Markup and config
      "markdown",
      "markdown_inline", -- For syntax highlighting in markdown code blocks
      "dockerfile",

      -- Web/data formats (useful for configs)
      "json",
      "yaml",
      "toml",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
}
