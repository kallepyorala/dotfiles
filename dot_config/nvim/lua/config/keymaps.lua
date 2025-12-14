-- lua/config/keymaps.lua
local M = {}

function M.setup()
  -- [[ Basic Keymaps ]]

  -- Auto-show diagnostics on cursor hold
  vim.diagnostic.config({ float = { border = 'rounded', source = true } })
  vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
      vim.diagnostic.open_float(nil, { focusable = false })
    end,
  })

  -- Clear highlights on search when pressing <Esc> in normal mode
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Merge conflict resolution
  vim.keymap.set('n', '<leader>gt', ':diffget //2<CR>', { desc = 'Get incoming changes (target/left)' })
  vim.keymap.set('n', '<leader>go', ':diffget //3<CR>', { desc = 'Get changes from branch being merged (ours/right)' })

  -- Quick Fix keymaps
  -- Basic operations
  vim.keymap.set('n', '<leader>qo', ':copen<CR>', { desc = 'Open [Q]uickfix' })
  vim.keymap.set('n', '<leader>qc', ':cclose<CR>', { desc = '[Q]uickfix [C]lose' })
  vim.keymap.set('n', '<leader>qd', vim.diagnostic.setloclist, { desc = '[Q]uickfix [D]iagnostics' })

  -- Navigation
  vim.keymap.set('n', '[q', ':cprev<CR>', { desc = 'Previous Quickfix Item' })
  vim.keymap.set('n', ']q', ':cnext<CR>', { desc = 'Next Quickfix Item' })
  vim.keymap.set('n', '[Q', ':cfirst<CR>', { desc = 'First Quickfix Item' })
  vim.keymap.set('n', ']Q', ':clast<CR>', { desc = 'Last Quickfix Item' })

  -- Advanced operations
  vim.keymap.set('n', '<leader>qa', ':cdo<Space>', { desc = '[Q]uickfix Run Command on [A]ll Items' })
  vim.keymap.set('n', '<leader>qf', ':cfdo<Space>', { desc = '[Q]uickfix Run Command on All [F]iles' })

  -- Terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
  
  -- Terminal window mappings for toggleterm
  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*toggleterm#*",
    callback = function()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end,
  })

  -- Window navigation
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- Buffer management
  vim.keymap.set('n', '<leader>ba', ':%bd<CR>', { desc = 'Close [B]uffers [A]ll' })
  vim.keymap.set('n', '[b', ':bprevious<CR>', { desc = 'Previous buffer' })
  vim.keymap.set('n', ']b', ':bnext<CR>', { desc = 'Next buffer' })

  -- Register and text manipulation
  vim.keymap.set('n', '<leader>p', 'viw"_dP', { desc = 'Replace inner word with register' })
  vim.keymap.set('n', '<leader>P', 'viW"_dP', { desc = 'Replace inner WORD with register' })

  -- Insert mode shortcuts
  vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true, desc = 'Exit insert mode with jj' })

  -- Optional arrow key restrictions (commented out by default)
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
end

return M
