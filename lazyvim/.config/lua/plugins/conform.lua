return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "autopep8" },
			html = { "html_beautify" },
		},
		formatters = {
			autopep8 = {
				exe = "autopep8",
				args = { "--indent-size", "2", "--aggressive", "--max-line-length", "100", "-" },
				stdin = true,
			},
			["php-cs-fixer"] = {
				-- This env var tells php-cs-fixer to stop complaining about missing composer.json
				env = {
					PHP_CS_FIXER_IGNORE_ENV = "1",
				},
			},
			html_beautify = {
				exe = "html-beautify",
				args = { "--indent-size", "2", "--wrap-line-length", "120" },
				stdin = true,
			},
		},
	},
}
