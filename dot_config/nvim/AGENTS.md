# AGENTS.md - Neovim Configuration

## Commands
- Format Lua: `stylua .` (config in `.stylua.toml`)
- Check config: `nvim --headless -c 'checkhealth' -c 'qa'`
- Validate syntax: `luacheck lua/` (if available)

## Architecture
- `init.lua` - Entry point, loads core modules and snippets
- `lua/config/` - Core config: options, keymaps, autocmds, lazy.nvim setup
- `lua/plugins/` - Plugin specs (one file per plugin, lazy.nvim format)
- `lua/lsp-config.lua` - LSP configurations
- `snippets/` - VSCode-style LuaSnip snippets

## Code Style
- Indent: 2 spaces (no tabs)
- Quotes: prefer single quotes
- Line width: 160 chars max
- Modules return tables with `setup()` function pattern
- Plugin files return lazy.nvim spec tables
- Leader key: space
- Use `vim.keymap.set()` for keymaps
- Follow existing patterns in `lua/plugins/` for new plugins
