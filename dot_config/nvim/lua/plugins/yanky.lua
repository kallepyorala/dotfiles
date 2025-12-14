return {
  'gbprod/yanky.nvim',
  event = 'VeryLazy',
  dependencies = {
    'kkharji/sqlite.lua', -- For persistent history
  },
  config = function()
    require('yanky').setup {
      ring = {
        history_length = 100,
        storage = 'sqlite',
        storage_path = vim.fn.stdpath 'data' .. '/databases/yanky.db',
        sync_with_numbered_registers = true,
        cancel_event = 'update',
        ignore_registers = { '_' },
        update_register_on_cycle = false,
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 500,
      },
      preserve_cursor_position = {
        enabled = true,
      },
      textobj = {
        enabled = true,
      },
    }

    vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)', { desc = 'Yanky yank' })

    vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)', { desc = 'Yanky put after' })
    vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)', { desc = 'Yanky put before' })
    vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)', { desc = 'Yanky put after and keep cursor' })
    vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)', { desc = 'Yanky put before and keep cursor' })

    vim.keymap.set('n', '<C-n>', '<Plug>(YankyNextEntry)', { desc = 'Show next yanked text' })
    vim.keymap.set('n', '<C-p>', '<Plug>(YankyPreviousEntry)', { desc = 'Show previous yanked text' })

    vim.keymap.set('n', ']p', '<Plug>(YankyPutIndentAfterLinewise)', { desc = 'Put indented after cursor' })
    vim.keymap.set('n', '[p', '<Plug>(YankyPutIndentBeforeLinewise)', { desc = 'Put indented before cursor' })

    vim.keymap.set('n', '>p', '<Plug>(YankyPutIndentAfterShiftRight)', { desc = 'Put and indent right' })
    vim.keymap.set('n', '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', { desc = 'Put and indent left' })
    vim.keymap.set('n', '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', { desc = 'Put before and indent right' })
    vim.keymap.set('n', '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', { desc = 'Put before and indent left' })
  end,
}
