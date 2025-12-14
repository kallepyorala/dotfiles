-- lua/config/autocmds.lua
local M = {}

function M.setup()
  -- Create autocommand groups
  local function create_augroup(name, opts)
    return vim.api.nvim_create_augroup('kickstart_' .. name, opts or { clear = true })
  end

  -- Highlight on yank
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = create_augroup 'highlight_yank',
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  -- Resize splits if window got resized
  vim.api.nvim_create_autocmd({ 'VimResized' }, {
    group = create_augroup 'resize_splits',
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd 'tabdo wincmd ='
      vim.cmd('tabnext ' .. current_tab)
    end,
  })

  -- Close certain filetypes with <q>
  vim.api.nvim_create_autocmd('FileType', {
    group = create_augroup 'close_with_q',
    pattern = {
      'PlenaryTestPopup',
      'help',
      'lspinfo',
      'man',
      'notify',
      'qf',
      'query',
      'spectre_panel',
      'startuptime',
      'tsplayground',
      'neotest-output',
      'checkhealth',
      'neotest-summary',
      'neotest-output-panel',
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end,
  })

  -- Wrap and check for spell in text filetypes
  vim.api.nvim_create_autocmd('FileType', {
    group = create_augroup 'wrap_spell',
    pattern = { 'gitcommit', 'markdown' },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

  -- Auto create dir when saving a file, in case some intermediate directory does not exist
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = create_augroup 'auto_create_dir',
    callback = function(event)
      if event.match:match '^%w%w+://' then
        return
      end
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end,
  })
end

return M
