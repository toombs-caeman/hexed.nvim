# 🔮 Hexed
Hexed is a thin Neovim wrapper around xxd for viewing and editing binary files as colored hex.

# 🧰 Installation [TODO]
### vim.pack
```lua
vim.pack.add({"https://github.com/toombs-caeman/hexed.nvim"})
require('hexed').setup('<leader>h') -- keymap optional
```

### [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
  "toombs-caeman/hexed.nvim",
  lazy = false,
  priority = 1000,
  opts = '<leader>h', -- optional
}
```

# Acknowledgements
* TODO list similar plugins
    * https://github.com/RaafatTurki/hex.nvim
* [inspo](https://simonomi.dev/blog/color-code-your-bytes/)
* [discussion](https://news.ycombinator.com/item?id=47846688)
