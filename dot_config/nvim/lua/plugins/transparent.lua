return {
  'xiyaowong/transparent.nvim',
  lazy = false, -- Important: avoid lazy-loading
  priority = 1000, -- High priority to load before other plugins
  config = function()
    require('transparent').setup {
      groups = { -- Default groups
        'Normal',
        'NormalNC',
        'Comment',
        'Constant',
        'Special',
        'Identifier',
        'Statement',
        'PreProc',
        'Type',
        'Underlined',
        'Todo',
        'String',
        'Function',
        'Conditional',
        'Repeat',
        'Operator',
        'Structure',
        'LineNr',
        'NonText',
        'SignColumn',
        'CursorLine',
        'CursorLineNr',
        'StatusLine',
        'StatusLineNC',
        'EndOfBuffer',
      },
      extra_groups = { -- Add any terminal-related groups
        'NormalFloat',
        'TerminalNormal',
        'Terminal',
        'TermCursor',
        'TermCursorNC',
        -- Dashboard specific groups
        'DashboardHeader',
        'DashboardCenter',
        'DashboardFooter',
        'DashboardMruTitle',
        'DashboardProjectTitle',
        'DashboardFiles',
        'DashboardShortCut',
      },
      exclude_groups = {}, -- Groups to not make transparent
    }
  end,
  -- Add keymaps to toggle transparency
  keys = {
    {
      '<leader>tt',
      '<cmd>TransparentToggle<cr>',
      desc = 'Toggle transparency',
    },
  },
}
