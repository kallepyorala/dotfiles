return {
  'akinsho/toggleterm.nvim',
  version = "*",
  event = "VeryLazy",
  config = function()
    require("toggleterm").setup({
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<C-/>]],
    hide_numbers = true,
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    float_opts = {
      border = 'curved',
      width = 100,
      height = 30,
      winblend = 0,
    },
    highlights = {
      Normal = {
        link = "Normal",
      },
      NormalFloat = {
        link = "Normal",
      },
      FloatBorder = {
        link = "FloatBorder",
      },
    },
    })
  end,
  init = function()
    -- Add a command to initialize lazygit terminal
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "curved",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
      end,
    })

    -- Create lazygit toggle function
    function _G._lazygit_toggle()
      lazygit:toggle()
    end
  end,
  
  keys = {
    -- Create a mapping for toggleterm lazygit integration
    {
      "<leader>gg",
      function()
        vim.cmd("lua _lazygit_toggle()")
      end,
      desc = "Lazygit"
    }
  }
}