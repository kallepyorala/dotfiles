return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false, -- Always use latest
  dependencies = {
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    -- Optional but recommended dependencies
    'hrsh7th/nvim-cmp', -- for autocompletion of avante commands
    'nvim-tree/nvim-web-devicons',
    {
      -- Support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
  opts = {
    provider = 'claude', -- Using Claude as recommended
    auto_suggestions_provider = 'claude',
    providers = {
      claude = {
        endpoint = 'https://api.anthropic.com',
        model = 'claude-opus-4-5-20251101',
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
    },
    mappings = {
      suggestion = {
        accept = '<C-a>',
        next = '<C-}>',
        prev = '<C-{>',
        dismiss = '<C-]>',
      },
    },
    behaviour = {
      auto_suggestions = false, -- Disabled as it's experimental
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,
    },
    windows = {
      position = 'right',
      wrap = true,
      width = 30,
      sidebar_header = {
        enabled = true,
        align = 'center',
        rounded = true,
      },
      input = {
        prefix = '> ',
        height = 8,
      },
      edit = {
        border = 'rounded',
        start_insert = true,
      },
      ask = {
        floating = false,
        start_insert = true,
        border = 'rounded',
        focus_on_apply = 'ours',
      },
    },
    file_selector = {
      provider = 'snacks',
      provider_opts = {},
    },
  },
  -- Build command
  build = 'make',
  config = function(_, opts)
    require('avante_lib').load()
    require('avante').setup(opts)
  end,
  -- Key mappings
  keys = {
    { '<leader>aa', '<cmd>AvanteToggle<cr>', desc = 'Toggle Avante sidebar' },
    { '<leader>ar', '<cmd>AvanteRefresh<cr>', desc = 'Refresh Avante windows' },
    { '<leader>af', '<cmd>AvanteFocus<cr>', desc = 'Switch Avante focus' },
    { '<leader>ae', '<cmd>AvanteEdit<cr>', desc = 'Edit selected blocks' },
    { '<leader>ac', '<cmd>AvanteChat<cr>', desc = 'Start Avante chat' },
    {
      '<C-a>',
      function()
        require('avante.api').get_suggestion():suggest()
      end,
      mode = 'i',
      desc = 'Trigger Avante suggestion',
    },
  },
}
