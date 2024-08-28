return {
	"hrsh7th/nvim-cmp",

	event = { "InsertEnter", "CmdlineEnter" },

	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		{
			"supermaven-inc/supermaven-nvim",
			-- commit = "df3ecf7",
			event = "User FilePost",
			opts = {
				disable_keymaps = false,
				disable_inline_completion = false,
				keymaps = {
					accept_suggestion = "<C-y>",
					clear_suggestion = "<Nop>",
				},
			},
		},
		{
			"Exafunction/codeium.nvim",
			enabled = true,
			opts = {
				enable_chat = true,
			},
		},
	},

	config = function()
		local luasnip = require("luasnip")
		luasnip.config.setup({})

		local cmp = require("cmp") -- See `:help cmp`
		cmp.setup({

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			completion = { completeopt = "menu,menuone,noinsert,noselect" },

			-- seriously. Please read `:help ins-completion`, it is really good!
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(), -- Select the [n]ext item
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(), -- Select the [p]revious item
				["<C-k>"] = cmp.mapping.select_prev_item(),
				-- select words from autocomplete list with tab/control
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<Esc>"] = cmp.mapping.close(),
				["<C-Space>"] = cmp.mapping.complete({}), -- Manually trigger a completion dropdown

				-- Think of <c-l> as moving to the right of your snippet expansion.
				--  So if you have a snippet that's like:
				--  function $name($args)
				--    $body
				--  end
				--
				-- <c-l> will move you to the right of each of the expansion locations.
				-- <c-h> is similar, except moving you backwards.
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),

				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			}),

			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
			},
		})
	end,
}
