-- debug.lua
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local wk = require 'which-key'

    -- Configure Python debugging
    require('dap-python').setup 'python'

    -- Replace the default Python attach configuration with our LangGraph-specific one
    dap.configurations.python = {
      {
        type = 'python',
        request = 'attach',
        name = 'LangGraph Server (port 5678)',
        host = '0.0.0.0',
        port = 5678,
        justMyCode = false,
        -- Add LangGraph-specific envs if needed
        -- env = {
        --   PYTHONPATH = '${workspaceFolder}'
        -- },
      },
    }

    -- Configure Debug UI
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Register debugging keymaps with which-key using v3 spec format
    wk.add {
      -- Debug group namespace
      { '<leader>d', name = 'Debug', mode = { 'n', 'v' } },

      -- Start/stop debugging
      {
        '<leader>dc',
        function()
          dap.disconnect() -- Clear any existing connection
          dap.continue() -- Attempt to attach
        end,
        desc = 'Start/Continue',
      },
      { '<leader>dx', dap.disconnect, desc = 'Disconnect/Stop' },

      -- Stepping
      { '<leader>di', dap.step_into, desc = 'Step Into' },
      { '<leader>do', dap.step_over, desc = 'Step Over' },
      { '<leader>du', dap.step_out, desc = 'Step Out' },

      -- Breakpoints
      { '<leader>db', dap.toggle_breakpoint, desc = 'Toggle Breakpoint' },
      {
        '<leader>dB',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Set Conditional Breakpoint',
      },

      -- UI and information
      { '<leader>dk', dapui.toggle, desc = 'Toggle UI' },
      { '<leader>dl', require('dap.ui.widgets').hover, desc = 'Look at value (Hover)' },
      { '<leader>dp', dap.pause, desc = 'Pause' },
      { '<leader>dr', dap.restart, desc = 'Restart' },
      { '<leader>ds', dap.session, desc = 'Get Session' },

      -- Breakpoint management
      {
        '<leader>dq',
        function()
          dap.list_breakpoints()
          vim.ui.select({
            'Cancel',
            'Clear All Breakpoints',
          }, {
            prompt = 'Breakpoint Action:',
          }, function(selected)
            if selected == 'Clear All Breakpoints' then
              dap.clear_breakpoints()
            end
          end)
        end,
        desc = 'List/Clear All Breakpoints',
      },
    }

    -- Auto open dap ui
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Ensure debugpy is installed
    require('mason-nvim-dap').setup {
      ensure_installed = { 'python', 'debugpy' },
      automatic_installation = true,
    }
  end,
}
