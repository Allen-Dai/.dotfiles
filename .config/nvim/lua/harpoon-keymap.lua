local harpoon_ui = require'harpoon.ui'
local harpoon_mark = require'harpoon.mark'
local opts = { noremap = ture, silent = true}
vim.keymap.set("n", "<leader>p", harpoon_ui.toggle_quick_menu, opts)
vim.keymap.set("n", "<leader>a", harpoon_mark.add_file, opts)
vim.keymap.set("n", "<leader>1", "<cmd>lua require'harpoon.ui'.nav_file(1)<CR>", opts)
vim.keymap.set("n", "<leader>2", "<cmd>lua require'harpoon.ui'.nav_file(2)<CR>", opts)
vim.keymap.set("n", "<leader>3", "<cmd>lua require'harpoon.ui'.nav_file(3)<CR>", opts)
vim.keymap.set("n", "<leader>4", "<cmd>lua require'harpoon.ui'.nav_file(4)<CR>", opts)
vim.keymap.set("n", "<leader>5", "<cmd>lua require'harpoon.ui'.nav_file(5)<CR>", opts)
