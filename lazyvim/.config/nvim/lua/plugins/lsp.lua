return {
	"neovim/nvim-lspconfig",
	opts = {
		autoformat = false,
		inlay_hints = { enabled = false },
		servers = {
			["*"] = {
				keys = {
					{ "<TAB>", vim.lsp.omnifunc, noremap = true, silent = true },
					{ "<leader>r", vim.lsp.buf.rename, noremap = true, silent = true },
					{ "<leader>h", vim.lsp.buf.hover, desc = "Hover", noremap = true, silent = true },
					{ "<space>q", vim.diagnostic.open_float, noremap = true, silent = true },
					{ "<space>a", vim.lsp.buf.code_action, noremap = true, silent = true },
					{ "<leader>cc", false, mode = { "n", "v", "x" } },
					{ "<C-i>", false, mode = { "n" } },
				},
			},
			basedpyright = {
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "recommended",
							diagnosticSeverityOverrides = {
								reportRedeclaration = "none",
							},
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							reportMissingImports = true,
							reportUnusedImport = true,
							reportOptionalMemberAccess = true,
							reportOptionalSubscript = true,
							reportOptionalCall = true,
							reportGeneralTypeIssues = true,
							reportPrivateImportUsage = true,
							reportIncompatibleMethodOverride = true,
							reportIncompatibleVariableOverride = true,
							reportDuplicateImport = true,
							reportInvalidStringEscapeSequence = true,
							reportAny = false,
						},
					},
				},
			},
		},
	},
}
