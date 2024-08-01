require("nvim-tree").setup({
  view = {
    adaptive_size = true,
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  },
  filters = {
    dotfiles = false,
  },
  renderer = {
    icons = {
      glyphs = {
        git = {
          staged = "+",
          untracked = "?",
          unstaged = "-"
        }
      }
    }
  }
})

vim.cmd("highlight NvimTreeFolderIcon guifg=#C09553")
vim.cmd("highlight NvimTreeIndentMarker guifg=#fd9353")
