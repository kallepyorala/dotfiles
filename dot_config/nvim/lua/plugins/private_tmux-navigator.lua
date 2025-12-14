return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  keys = {
    { '<c-h>', '<cmd>TmuxNavigateLeft<cr>', { silent = true, desc = 'navigate left' } },
    { '<c-j>', '<cmd>TmuxNavigateDown<cr>', { silent = true, desc = 'navigate down' } },
    { '<c-k>', '<cmd>TmuxNavigateUp<cr>', { silent = true, desc = 'navigate up' } },
    { '<c-l>', '<cmd>TmuxNavigateRight<cr>', { silent = true, desc = 'navigate right' } },
  },
}
