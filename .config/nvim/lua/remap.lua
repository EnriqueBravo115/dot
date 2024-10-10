vim.g.mapleader = " "
vim.g.maplocalleader = ","
local jdtls = require("jdtls")
local set = vim.keymap.set
local opts = { noremap = true, silent = true }
local builtin = require("telescope.builtin")
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- COMMANDS
vim.keymap.set("n", "<leader>e", "<cmd>:NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
vim.keymap.set("n", "<leader>ñ", "<cmd>:MarkdownPreview<CR>")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<C-p>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-q>", "<cmd>cprev<CR>zz")
vim.keymap.set("v", "j", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "k", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- TELESCOPE
vim.keymap.set("n", "<leader>lc", "<cmd>:lua require'telescope'.extensions.dap.commands{}<CR>")

vim.keymap.set("n", "<leader>ff",
  "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_ivy({previewer=false}))<cr>",
  opts)

vim.keymap.set("n", "<leader>bf",
  "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_ivy({previewer=false}))<cr>", opts)

vim.keymap.set('n', '<leader>fo',
  "<cmd>lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_ivy({previewer=false}))<cr>",
  opts
)

vim.keymap.set("n", "<leader>ww", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- Harpoon
vim.keymap.set("n", "<C-s>", mark.add_file)
vim.keymap.set("n", "<C-d>", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end)
vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end)

-- Color line yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Exit from window
vim.api.nvim_exec([[
  tnoremap <esc><esc> <C-\><C-n>:wincmd w<CR>
]], false)

-- DAP
set("n", "<leader>as", vim.diagnostic.setloclist)

set("n", "<leader>dc", function()
  require("dap").continue()
end)
set("n", "<leader>dt", function()
  require("dap").toggle_breakpoint()
end)
set("n", "<leader>dso", function()
  require("dap").step_over()
end)
set("n", "<leader>dsi", function()
  require("dap").step_into()
end)
set("n", "<leader>dr", function()
  require("dap").repl.toggle()
end)

-- DAP java test
set("n", "<leader>df", function()
  if vim.bo.modified then
    vim.cmd("w")
  end
  jdtls.test_class()
end, opts)

set("n", "<leader>dn", function()
  if vim.bo.modified then
    vim.cmd("w")
  end
  jdtls.test_nearest_method({
    config_overrides = {
      stepFilters = {
        skipClasses = { "$JDK", "junit.*" },
        skipSynthetics = true
      }
    }
  })
end, opts)
