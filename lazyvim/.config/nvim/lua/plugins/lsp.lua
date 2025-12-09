return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ['*'] = {
        keys = {
          { "<TAB>", vim.lsp.omnifunc, noremap=true, silent=true },
          { "<leader>r", vim.lsp.buf.rename, noremap=true, silent=true },
          { "<leader>h", vim.lsp.buf.hover, desc = "Hover", noremap=true, silent=true },
          { '<space>q', vim.diagnostic.open_float, noremap=true, silent=true },
        },
      },
    },
  },
}
