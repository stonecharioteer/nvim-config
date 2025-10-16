---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    -- Size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
    direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.8),
      winblend = 3,
      zindex = 50,
    },
    winbar = {
      enabled = false,
      name_formatter = function(term) -- term: Terminal
        return term.name
      end,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Custom terminal instances
    local Terminal = require("toggleterm.terminal").Terminal

    -- Lazygit terminal
    local lazygit = Terminal:new {
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * 0.9),
        height = math.floor(vim.o.lines * 0.9),
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd "startinsert!"
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function(term) vim.cmd "startinsert!" end,
    }

    function _LAZYGIT_TOGGLE() lazygit:toggle() end

    -- Python REPL
    local python = Terminal:new {
      cmd = "python",
      direction = "float",
      close_on_exit = false,
    }

    function _PYTHON_TOGGLE() python:toggle() end

    -- Node REPL
    local node = Terminal:new {
      cmd = "node",
      direction = "float",
      close_on_exit = false,
    }

    function _NODE_TOGGLE() node:toggle() end

    -- Htop
    local htop = Terminal:new {
      cmd = "htop",
      direction = "float",
      close_on_exit = true,
    }

    function _HTOP_TOGGLE() htop:toggle() end
  end,
  keys = {
    -- Basic toggle
    { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal", mode = { "n", "t" } },
    -- Terminal direction toggles
    {
      "<leader>tf",
      "<cmd>ToggleTerm direction=float<cr>",
      desc = "ToggleTerm float",
    },
    {
      "<leader>th",
      "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
      desc = "ToggleTerm horizontal split",
    },
    {
      "<leader>tv",
      "<cmd>ToggleTerm size=80 direction=vertical<cr>",
      desc = "ToggleTerm vertical split",
    },
    -- Custom terminals
    { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "LazyGit" },
    { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", desc = "Python REPL" },
    { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<CR>", desc = "Node REPL" },
    { "<leader>tH", "<cmd>lua _HTOP_TOGGLE()<CR>", desc = "Htop" },
  },
}
