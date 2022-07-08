local cmp = require("cmp")
local lsp_status = require("lsp-status")
lsp_status.register_progress()

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
}

local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			-- For `vsnip` user.
			-- vim.fn["vsnip#anonymous"](args.body)

			-- For `luasnip` user.
			require("luasnip").lsp_expand(args.body)

			-- For `ultisnips` user.
			-- vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),

        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),

        ['<CR>'] = cmp.mapping.confirm({ select = false }),
		["<C-Space>"] = cmp.mapping.complete(),
	},

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == 'cmp_tabnine' then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. ' ' .. menu
                end
                vim_item.kind = ""
            end
            vim_item.menu = menu
            return vim_item
        end
    },

	sources = {
        -- tabnine completion

        { name = "cmp_tabnine" },

		{ name = "nvim_lsp" },

		-- For vsnip user.
		-- { name = 'vsnip' },

		-- For luasnip user.
		{ name = "luasnip" },

		-- For ultisnips user.
		-- { name = 'ultisnips' },

		{ name = "buffer" },
	},
})

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = '..',
})

--[[ local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}, _config or {})
end --]]

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())


local nvim_lsp = require'lspconfig'

-- lsp config
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

-- CSharp lsp
local omnisharp_bin = os.getenv("HOME") .. "/omnisharp/run"
local pid = vim.fn.getpid()
require'lspconfig'.omnisharp.setup{
    on_attach = on_attach,
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    -- config()
    capabilities = capabilities
}

-- Lua lsp
--[[ local sumneko_bin = os.getenv("HOME") .. "/lualsp/bin/lua-language-server"
local sumneko_root_path = os.getenv("HOME") .. "/lualsp/main.lua"
require'lspconfig'.sumneko_lua.setup{
    cmd = { sumneko_bin, "-E", sumneko_root_path },
    on_attach = on_attach,
    -- config()
    capabilities = capabilities
} --]]

-- who even uses this? - Yes who THE FUCK use this.
require("lspconfig").rust_analyzer.setup{
	cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    on_attach = on_attach,
    capabilities = capabilities
	--[[
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
        },
    }
    --]]
}

-- Lsp that can start without cmd
local servers = {'pylsp', 'tsserver', 'ccls'}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup{
        on_attach = on_attach,
        -- config()
        capabilities = capabilities
    }
end

-- Diagnostic config
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        update_in_insert = true,
        underline = true,
        signs = true,
    })
