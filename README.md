# 🔮 Hexed
Hexed is a thin Neovim wrapper around xxd for viewing and editing binary files as colored hex.

# ❓ Why
The idea came from [a blog post](https://simonomi.dev/blog/color-code-your-bytes/)
which talks about coloring hex values with a unique color per high nibble.
The idea was further refined in some [hn discussion](https://news.ycombinator.com/item?id=47846688)
which commented that the binary values should be colored in the same fashion as the hex data.

# 🧰 Installation
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
  opts = '<leader>h', -- optional
}
```

# TODO
* color the right hand column the same as the corresponding hex values.
    * This already works, except that non-printable characters are all replaced with `.` by xxd.
    * there isn't a easy way to distinguish how `.` should be colored.
* vim.b.hexed can get 'out of sync' if you use `u` to undo a hexing or unhexing.
* when viewing a binary file, Neovim replaces non-printable characters with placeholders, which cannot be highlighted the same way as non-placeholders.
* testing to make sure that the cursor is always correctly placed when toggling

# Similar plugins
* [hex.nvim](https://github.com/RaafatTurki/hex.nvim)
    * I want hexed to be "less magic" than hex.nvim.
    * this doesn't give as nicely colored output.
