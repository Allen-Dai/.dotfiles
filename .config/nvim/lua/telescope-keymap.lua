require('telescope').load_extension('fzy_native')
require('telescope').setup({
    pickers = {
        git_files = {
            show_untracked = true
        }
    }
})

local telescope = require('telescope.builtin')
local opts = { noremap = ture, silent = true}
vim.keymap.set("n", "<space>p", telescope.git_files, opts)
vim.keymap.set("n", "<leader>ff", telescope.find_files, opts)
vim.keymap.set("n", "<space>g", telescope.live_grep, opts)
vim.keymap.set("n", "<space>w", telescope.grep_string, opts)
