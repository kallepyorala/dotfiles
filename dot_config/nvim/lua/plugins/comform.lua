return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        if vim.bo.filetype == 'python' then
          vim.lsp.buf.code_action {
            ---@diagnostic disable-next-line: missing-fields
            context = {
              ---@diagnostic disable-next-line: assign-type-mismatch
              only = { 'source.fixAll.ruff' },
            },
            apply = true,
          }
        end
        -- JS/TS: Use Biome instead of ESLint
        local js_filetypes = {
          javascript = true,
          typescript = true,
          javascriptreact = true,
          typescriptreact = true,
        }
        if js_filetypes[vim.bo.filetype] then
          vim.lsp.buf.code_action {
            ---@diagnostic disable-next-line: missing-fields
            context = {
              ---@diagnostic disable-next-line: assign-type-mismatch
              only = { 'source.fixAll.biome' },
              diagnostics = {},
            },
            apply = true,
          }
        end
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback-- for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- JS/TS formatting handled by Biome LSP
    },
  },
}
