vim.keymap.set("n", "<space>", "<nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tab and Indent behaviour
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.wrap = true
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.o.linebreak = true
vim.o.breakindent = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.signcolumn = "yes"

-- Search settings
vim.o.ignorecase = true
vim.o.smartcase = true

-- Clipboard using win32yank
vim.opt.clipboard = "unnamedplus"
vim.g.have_nerd_font = true

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking",
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Split navigation
vim.keymap.set("n", "<C-h>", "<C-W><C-H>")
vim.keymap.set("n", "<C-l>", "<C-W><C-L>")
vim.keymap.set("n", "<C-k>", "<C-W><C-K>")
vim.keymap.set("n", "<C-j>", "<C-W><C-J>")

-- Split resizing
vim.keymap.set("n", "<leader><C-H>", "5<C-W><")
vim.keymap.set("n", "<leader><C-L>", "5<C-W>>")

-- Clear search highlighting
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear search highlighting" })

require("config.lazy")

-- Telescope keybinds
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- Colorscheme
vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd([[colorscheme tokyonight-night]])
