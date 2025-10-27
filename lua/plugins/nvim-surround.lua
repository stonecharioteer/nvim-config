-- nvim-surround: Add/delete/change surrounding delimiters
-- https://github.com/kylechui/nvim-surround

---@type LazySpec
return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup {
      -- Configuration here, or leave empty to use defaults
      -- See :h nvim-surround.configuration for more details
    }
  end,
}
