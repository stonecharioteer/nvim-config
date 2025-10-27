-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- opts variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics

    -- Only insert new sources, do not replace the existing ones
    -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- Ruby formatting with bundle exec rubocop -a
      null_ls.builtins.formatting.rubocop.with {
        command = "bundle",
        args = { "exec", "rubocop", "-a", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" },
        -- Only run if Gemfile exists (project uses bundler)
        condition = function(utils)
          return utils.root_has_file "Gemfile"
        end,
      },

      -- Markdown formatting with prettier
      null_ls.builtins.formatting.prettier.with {
        filetypes = { "markdown", "json", "yaml", "toml" },
      },
    })
  end,
}
