-- Load core configurations
require('config.options').setup()
require('config.keymaps').setup()
require('config.autocmds').setup()
require('config.lazy').setup()

-- Load snippet configurations
require('luasnip.loaders.from_vscode').lazy_load { paths = '~/.config/nvim/snippets' }

-- vim: ts=2 sts=2 sw=2 et
