return {
  {
    'ggandor/flit.nvim',
    dependencies = {
      'ggandor/leap.nvim', -- flit.nvim requires leap.nvim
    },
    opts = {
      keys = { f = 'f', F = 'F', t = 't', T = 'T' },
      labeled_modes = 'v',
      clever_repeat = true,
      multiline = true,
      opts = {},
    },
  },
}
