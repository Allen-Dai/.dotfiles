local opts = { noremap = ture, silent = true}
local keymap = vim.api.nvim_set_keymap
keymap("n", "<space>p", ":lua require('telescope.builtin').git_files()<CR>", opts)
keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<space>g", ":lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<space>w", ":lua require('telescope.builtin').grep_string()<CR>", opts)
