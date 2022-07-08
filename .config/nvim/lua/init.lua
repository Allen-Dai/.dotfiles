require('lsp')
require('treesitter')
require('statusline')
require('telescope-keymap')
require('nvim-web-devicons').get_icons()
require('debugger')
require('Comment').setup()
require('nightfox').setup({
    options={
        transparent=true
    }
})
require('status')
require("nvim-lsp-installer").setup {}
